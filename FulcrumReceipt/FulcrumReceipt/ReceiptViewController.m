//
//  ReceiptViewController.m
//  FulcrumReceipt
//
//  Created by wanny on 10/22/12.
//  Copyright (c) 2012 com.mrwanny. All rights reserved.
//

#import "ReceiptViewController.h"

@interface ReceiptViewController ()

@end

@implementation ReceiptViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textView setText:self.receipt];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
