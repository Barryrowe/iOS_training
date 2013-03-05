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

@interface ItemsViewController()
@property (nonatomic, strong) IBOutlet UIView *headerView;

- (IBAction) addNewItem:(id) sender;
//- (IBAction) toggleEditingMode:(id)sender;

@end

@implementation ItemsViewController

//
//Custom Implementations
//
- (BOOL)isIndexLastIndex:(NSIndexPath *)indexPath {
    if(indexPath && [indexPath row] == [[[BNRItemStore sharedStore] allItems] count]){
        return YES;
    }else{
        return NO;
    }
}

//// Removing HeaderView Code
//- (UIView *) headerView{
//    // If We haven't loaded the headerView yet...
//    if(!_headerView){
//        //Load HeaderView.xib
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
//                                      owner:self
//                                    options:nil];
//    }
//    return _headerView;
//}
//
//- (IBAction)toggleEditingMode:(id)sender{
//    // If we are in editting mode
//    if([self isEditing]){
//        // Change text of button to inform user
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        // Turn Off Editing Mode
//        [self setEditing:NO animated:YES];
//    }else{
//        // Change text of button to inform user
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        // Turn Off Editing Mode
//        [self setEditing:YES animated:YES];
//    }
//}

- (IBAction)addNewItem:(id)sender{

    BNRItem *newItem    = [[BNRItemStore sharedStore] createItem];
    // Figure out where that item is in the array
    int lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    //Inser the new item into our table
    [[self tableView] insertRowsAtIndexPaths:@[ip]
                            withRowAnimation:UITableViewRowAnimationTop];
}
//-----


//
//UIViewController Overrides
//
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (id)init{
    // Call the super class's designated initializers
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"Homepwner"];
        
        //Create a new bar button item that will send
        //  addNewItem: to ItemsViewController
        UIBarButtonItem *bbiAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(addNewItem:)];
        
        //Set this button as this ViewController's NavigationBar's right item
        [[self navigationItem] setRightBarButtonItem:bbiAdd];
        
        
        //Set this new button as the viewController's NavigationBar's left item
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    }
    return self;
}

- (id) initWithStyle:(UITableViewStyle)style{
    return [self init];
}

//-----

//
//UITableViewDelegate protocol Implementation
//
////Removing code for headView Added
//- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)section{
//    return [self headerView];
//}
//
//- (CGFloat)tableView:(UITableView *)tv heightForHeaderInSection:(NSInteger)section{
//    // The height of the header view should be determined from the height of the
//    // view in the xib file
//    return [[self headerView] bounds].size.height;
//}
//-----


//
//UITableViewDataSource Implementations
//
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger c = [[[BNRItemStore sharedStore] allItems] count];
    NSLog(@"Count is Called %d",c);
    return c + 1;
}

- (NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Remove";
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return ![self isIndexLastIndex:indexPath];
}


- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return ![self isIndexLastIndex:indexPath];
}

- (void) tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = [items objectAtIndex:[indexPath row]];
    
    // Give detail view controller a pointer to the item object in row
    [detailViewController setItem:item];
    
    // Push it onto the top of the navigation controller's stack
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

- (NSIndexPath *) tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if([self isIndexLastIndex:proposedDestinationIndexPath]){
        return sourceIndexPath;
    }else{
        return proposedDestinationIndexPath;
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
    
    
    if([self isIndexLastIndex:indexPath]){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EndItem"];
        [[cell textLabel] setText:@"No More Items!"];
        
    }else{
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the Table View
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *p = [items objectAtIndex:[indexPath row]];

        NSLog(@"%@ ", [p description]);
        [[cell textLabel] setText:[p description]];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // if the table view is asking to commit a delete command...
    if(editingStyle == UITableViewCellEditingStyleDelete){
        BNRItemStore *ps = [BNRItemStore sharedStore];
        NSArray *items = [ps allItems];
        BNRItem *p = [items objectAtIndex:[indexPath row]];
        [ps removeItem:p];
        
        // We also remove that row from the table view with animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    [[BNRItemStore sharedStore] movieItemAtIndex:[sourceIndexPath row] toIndex:[destinationIndexPath row]];
}
//-----

@end
