//
//  InputCell.h
//  FulcrumReceipt
//
//  Created by wanny on 10/22/12.
//  Copyright (c) 2012 com.mrwanny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UITextField *quantity;
@property (nonatomic,strong) IBOutlet UITextField *itemDescription;
@property (nonatomic,strong) IBOutlet UITextField *price;

@property (nonatomic,strong) IBOutlet UIButton *addButton;
@end
