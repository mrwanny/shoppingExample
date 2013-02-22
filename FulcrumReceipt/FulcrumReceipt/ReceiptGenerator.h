//
//  ReceiptGenerator.h
//  FulcrumReceipt
//
//  Created by wanny on 10/21/12.
//  Copyright (c) 2012 com.mrwanny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiptGenerator : NSObject

/*
 * check if "imported" is contained in item
 * may need to be refactored using a catalog where to lookup imported object
 */
+(BOOL) isItemImported:(NSString*)item;
/*
 * check if "book"| "pill" | "food" | "chocolate" is contained in item
 * may need to be refactored using a catalog where to lookup tax exempt object
 */
+(BOOL) isItemTaxExempt:(NSString*)item;

+(float) taxRateForItem:(NSString*)item;

+(NSDictionary*) parseBasketLine:(NSString*)line;

+(NSString*)generateReceiptFromBasket:(NSString*)basket;


@end
