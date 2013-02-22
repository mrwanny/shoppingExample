//
//  ShoppingChartViewController.m
//  FulcrumReceipt
//
//  Created by wanny on 10/22/12.
//  Copyright (c) 2012 com.mrwanny. All rights reserved.
//

#import "ShoppingChartViewController.h"
#import "InputCell.h"
#import "ReceiptGenerator.h"
#import "ReceiptViewController.h"

#define INPUTSECTION 0
#define LISTSECTION 1


@interface ShoppingChartViewController ()

@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) InputCell *inputCell;


@end

@implementation ShoppingChartViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setItems:[NSMutableArray arrayWithCapacity:1]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == INPUTSECTION) {
        return 1;
    }
    if (section == LISTSECTION) {
        return [self.items count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == INPUTSECTION) {
        
        return 104;
        
    }
    if (indexPath.section == LISTSECTION) {
        
        return 44;
    }
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == INPUTSECTION) {
        if (self.inputCell == nil) {
            [self setInputCell: [tableView dequeueReusableCellWithIdentifier:@"InputCell" forIndexPath:indexPath]];
            
            [self.inputCell.addButton addTarget:self action:@selector(addItemToShoppingLIst) forControlEvents:UIControlEventTouchDown];
        }
        return self.inputCell;
    }
    
    if (indexPath.section == LISTSECTION) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BasicCell" forIndexPath:indexPath];
        [cell.textLabel setText:[self.items objectAtIndex:indexPath.row]];
        return cell;
    }
    
    
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(IBAction)clearTable:(id)sender{
    [self.items removeAllObjects];
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:LISTSECTION] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)addItemToShoppingLIst {
    if ([self.inputCell.quantity.text intValue] == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"please add a quantity greater than 0" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
        return;
    }
    
    if ([self.inputCell.itemDescription.text length] == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"please add an item description" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
        return;
    }
    
    if ([self.inputCell.price.text floatValue] <= 0) {
        [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"please add a positive price" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
        return;
    }
    
    [self.inputCell.quantity resignFirstResponder];
    [self.inputCell.itemDescription resignFirstResponder];
    [self.inputCell.price resignFirstResponder];
    
    [self.items addObject:[NSString stringWithFormat:@"%d %@ at %.2f",[self.inputCell.quantity.text intValue],self.inputCell.itemDescription.text,[self.inputCell.price.text floatValue]]];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:LISTSECTION] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CheckOutSegue"]) {
        NSLog(@"CheckOutSegue");

        if ([self.items count] == 0 ) {
            [(ReceiptViewController*)segue.destinationViewController setReceipt:@"Your Shopping cart is empty"];
        }else {
            [(ReceiptViewController*)segue.destinationViewController setReceipt:[ReceiptGenerator generateReceiptFromBasket:[self.items componentsJoinedByString:@"\n"]]];
        }

        
    }
}

@end
