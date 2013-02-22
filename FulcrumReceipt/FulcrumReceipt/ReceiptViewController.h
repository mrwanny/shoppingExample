//
//  ReceiptViewController.h
//  FulcrumReceipt
//
//  Created by wanny on 10/22/12.
//  Copyright (c) 2012 com.mrwanny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITextView *textView;
@property (nonatomic,copy) NSString *receipt;

@end
