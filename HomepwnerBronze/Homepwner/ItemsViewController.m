//
//  ItemsViewControllerAgain.m
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController

//
//UITableViewController Implmentations
//
- (id)init{
    // Call the super class's designated initializers
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
        for(int i=0;i<20;i++){
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (id) initWithStyle:(UITableViewStyle)style{
    return [self init];
}
//-----


//
//UITableViewDataSource Implementations
//
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Worth $50+";
    }else{
        return @"Worth < $50";
    }
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        NSPredicate *fiftyPlus = [NSPredicate predicateWithFormat:@"valueInDollars > 50"];
        return [[[[BNRItemStore sharedStore] allItems] filteredArrayUsingPredicate:fiftyPlus] count];
    }else{
        NSPredicate *lessThanFifty = [NSPredicate predicateWithFormat:@"valueInDollars < 50"];
        return [[[[BNRItemStore sharedStore] allItems] filteredArrayUsingPredicate:lessThanFifty] count];        
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    //If There is no reusable cell available we need to create one
    if(!cell){
        // Create an instance of UITableViewCell, with default appearance
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                       reuseIdentifier:@"UITableViewCell"];
    }
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the Table View
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    NSSortDescriptor *sortByPrice = [NSSortDescriptor sortDescriptorWithKey:@"valueInDollars" ascending:NO];


    items = [[BNRItemStore sharedStore] sortByDescriptor:sortByPrice];
    NSLog(@"%@", items);

    NSInteger section = [indexPath section];
    
    NSInteger baseCount;
    if(section == 0){
        baseCount = 0;
    }else{
        baseCount = [self tableView:tableView numberOfRowsInSection:0];
    }
    
    NSInteger trueIndex = baseCount + [indexPath row];
    BNRItem *p = [items  objectAtIndex:trueIndex];
    [[cell textLabel] setText:[p description]];
    
    return cell;
}
//-----

@end
