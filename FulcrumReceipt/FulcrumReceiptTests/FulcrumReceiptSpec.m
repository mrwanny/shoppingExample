#import "Kiwi.h"
#import "ReceiptGenerator.h"

SPEC_BEGIN(FulcrumReceiptSpec)

describe(@"FulcrumReceipt", ^{
    
    it(@"check if is imported", ^{
        [[ReceiptGenerator should] respondsToSelector:@selector(isItemImported:)];
        [[theValue([ReceiptGenerator isItemImported:@"something is imported"]) should] equal:theValue(YES)];
        [[theValue([ReceiptGenerator isItemImported:@"something else"]) should] equal:theValue(NO)];
        
    });
    
    it(@"check if is tax exempt", ^{
        [[ReceiptGenerator should] respondsToSelector:@selector(isItemTaxExempt:)];
        [[theValue([ReceiptGenerator isItemTaxExempt:@"a very beautiful book"]) should] equal:theValue(YES)];
        [[theValue([ReceiptGenerator isItemTaxExempt:@"a very beautiful chocolate"]) should] equal:theValue(YES)];
        [[theValue([ReceiptGenerator isItemTaxExempt:@"a very beautiful pill"]) should] equal:theValue(YES)];
        [[theValue([ReceiptGenerator isItemTaxExempt:@"something else"]) should] equal:theValue(NO)];
        
    });
    
    it(@"compute tax rate", ^{
        [[ReceiptGenerator should] respondsToSelector:@selector(taxRateForItem:)];
        [[theValue([ReceiptGenerator taxRateForItem:@"domestic book"]) should] equal:theValue(0.0f)];
        [[theValue([ReceiptGenerator taxRateForItem:@"imported book"]) should] equal:theValue(0.05f)];
        [[theValue([ReceiptGenerator taxRateForItem:@"imported something else"]) should] equal:theValue(0.15f)];
        
    });
    
    it(@"should parse Basket Line", ^{
        [[ReceiptGenerator should] respondsToSelector:@selector(parseBasketLine:)];
        NSDictionary *productDetail = [ReceiptGenerator parseBasketLine:@"1 imported box of chocolates at 10.00"];
        [[[productDetail objectForKey:@"number"] should] equal:[NSNumber numberWithInt:1]];
        [[[productDetail objectForKey:@"item"] should] equal:@"imported box of chocolates"];
        [[[productDetail objectForKey:@"price"] should] equal:[NSNumber numberWithFloat:10.00]];
    });
    
    it(@"textcase  1", ^{
        /*
         1 book at 12.49
         1 music CD at 14.99
         1 chocolate bar at 0.85
         */
        /*
         1 book : 12.49
         1 music CD: 16.49
         1 chocolate bar: 0.85
         Sales Taxes: 1.50
         Total: 29.83
         */
        
        [[[ReceiptGenerator generateReceiptFromBasket:@"1 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85"] should] equal:@"1 book: 12.49\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 29.83"];
        
    });
    it(@"textcase  2", ^{
       /*
        1 imported box of chocolates at 10.00
        1 imported bottle of perfume at 47.50
        */
       /*
        1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
        */
        
        [[[ReceiptGenerator generateReceiptFromBasket:@"1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50"] should] equal:@"1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15"];
        
        
    });
    it(@"textcase  3", ^{
       /*
        1 imported bottle of perfume at 27.99
        1 bottle of perfume at 18.99
        1 packet of headache pills at 9.75
        1 imported box of chocolates at 11.25
        */
       /*
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        1 imported box of chocolates: 11.85
        Sales Taxes: 6.70
        Total: 74.68
        */
        [[[ReceiptGenerator generateReceiptFromBasket:@"1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n1 imported box of chocolates at 11.25"] should] equal:@"1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n1 imported box of chocolates: 11.85\nSales Taxes: 6.70\nTotal: 74.68"];
        
        

        
    });
});



SPEC_END