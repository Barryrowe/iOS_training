//
//  DetailViewController.m
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation DetailViewController


//
//UIViewController Overrides
//
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    BNRItem *item = [self item];
    [[self nameField] setText:[item itemName]];
    [[self serialNumberField] setText:[item serialNumber]];
    [[self valueField] setText:[NSString stringWithFormat:@"%d",[item valueInDollars]]];
    
    //Create a NSDate Fromater that will format our date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    
    // Use filtered NSDate object to set the Date Label
    [[self dateLabel] setText:[formatter stringFromDate:[item dateCreated]]];
}

- (void) viewWillDisappear:(BOOL)animated   {
    [super viewWillDisappear:animated];
    
    // Clear First Responder
    [[self view] endEditing:YES];
    
    // "Save" our changes to the item
    BNRItem *item = [self item];
    [item setItemName:[[self nameField] text]];
    [item setSerialNumber:[[self serialNumberField] text]];
    [item setValueInDollars:[[[self valueField] text] intValue]];
}

- (void) setItem:(BNRItem *)item{
    _item = item;
    [[self navigationItem] setTitle:[[self item] itemName]];
}
//-----
@end
