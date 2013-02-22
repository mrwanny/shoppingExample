//
//  ReceiptGenerator.m
//  FulcrumReceipt
//
//  Created by wanny on 10/21/12.
//  Copyright (c) 2012 com.mrwanny. All rights reserved.
//

#import "ReceiptGenerator.h"

@implementation ReceiptGenerator

+(BOOL) isItemImported:(NSString*)item{
    if ([item rangeOfString:@"imported"].location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}
+(BOOL) isItemTaxExempt:(NSString*)item{
    if ([item rangeOfString:@"book"].location != NSNotFound) {
        return YES;
    }else if ([item rangeOfString:@"pill"].location != NSNotFound) {
        return YES;
    }else if (([item rangeOfString:@"food"].location != NSNotFound) ||
              ([item rangeOfString:@"chocolate"].location != NSNotFound)) {
        return YES;
    }else {
        return NO;
    }
}

+(double) taxRateForItem:(NSString*)item{
    double tax = 0;
    if (![ReceiptGenerator isItemTaxExempt:item]) {
        tax +=0.1;
    }
    if ([ReceiptGenerator isItemImported:item]) {
        tax +=0.05;
    }
    return tax;
}

+(NSDictionary*) parseBasketLine:(NSString*)line {
    
    NSScanner *aScanner = [NSScanner scannerWithString:line];
    
    NSInteger number = 0;
    NSString *item;
    float price = 0;
    
    if ([aScanner scanInteger:&number] &&
        [aScanner scanUpToString:@" at " intoString:&item] &&
        [aScanner scanString:@"at" intoString:NULL] &&
        [aScanner scanFloat:&price]  ){
        
        return @{@"number" : [NSNumber numberWithInt:number], @"item" : item, @"price" : [NSNumber numberWithFloat:price]};
    }else {
        return nil;
    }
}


+(NSString*)generateReceiptFromBasket:(NSString*)basket{
    NSArray *lines = [basket componentsSeparatedByString:@"\n"];
    NSMutableString *receipt = [NSMutableString stringWithCapacity:[basket length]];
    
    float netTotal = 0;
    float taxTotal = 0;
    
    for (NSString *line in lines) {
        NSDictionary *productDetail = [ReceiptGenerator parseBasketLine:line];
        if (productDetail) {
            int number = [[productDetail objectForKey:@"number"] intValue];
            float price = number*[[productDetail objectForKey:@"price"] floatValue];
            float tax = ceil(price*[ReceiptGenerator taxRateForItem:[productDetail objectForKey:@"item"]]*20.0)/20.0;
            taxTotal += tax;
            netTotal += price;
            
            [receipt appendFormat:@"%d %@: %.2f\n",number,[productDetail objectForKey:@"item"],price+tax ];
        }
    }
    [receipt appendFormat:@"Sales Taxes: %.2f\n",taxTotal ];
    [receipt appendFormat:@"Total: %.2f",netTotal+taxTotal ];
    return receipt;
}
@end
