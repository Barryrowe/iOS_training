//
//  AssetTypePicker.m
//  Homepwner_CoreData
//
//  Created by Admin on 3/7/13.
//
//

#import "AssetTypePicker.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation AssetTypePicker

//
//Core Methods
//
- (id) init{
    return [super initWithStyle:UITableViewStyleGrouped];
}
//-----

//
//UITableViewController Implementaions
//
- (id) initWithStyle:(UITableViewStyle)style{
    return [self init];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[BNRItemStore sharedStore] allAssetTypes] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
    NSManagedObject *assetType = [allAssets objectAtIndex:[indexPath row]];
    
    // Use key-value coding to get the asset type's label
    NSString *assetLabel = [assetType valueForKey:@"label"];
    [[cell textLabel] setText:assetLabel];
    
    // Checkmark the one that is currently selected
    if(assetType == [[self item] assetType]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"Cell Selected");
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    NSArray *allAssets = [[BNRItemStore sharedStore] allAssetTypes];
    NSManagedObject *assetType = [allAssets objectAtIndex:[indexPath row]];
    [[self item] setAssetType:assetType];
    
    [[self navigationController] popViewControllerAnimated:YES];
}
//-----
@end
