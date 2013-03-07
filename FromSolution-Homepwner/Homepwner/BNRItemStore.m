//
//  BNRItemStore.m
//  Homepwner
//
//  Created by joeconway on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore(){
    
    NSMutableArray *allItems;
    NSMutableArray *_allAssetTypes;
    NSManagedObjectContext *_context;
    NSManagedObjectModel *_model;
}

- (NSString *)itemArchivePath;
- (void) loadAllItems;

@end

@implementation BNRItemStore

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if(!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];
        
    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

- (id)init 
{
    self = [super init];
    if(self) {
        // Read in Homepwner.xcdatamodeld
        _model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
        
        // Where to we put the SQLite File?
        NSString *path = [self itemArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:storeURL
                                    options:nil
                                      error:&error]){
            [NSException raise:@"Open Failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        // Create the managed object context
        _context = [[NSManagedObjectContext alloc] init];
        [_context setPersistentStoreCoordinator:psc];
        
        // The managed object context can manage undo, but we don't need it
        [_context setUndoManager:nil];
        
        // Load up our shit!
        [self loadAllItems];
    }
    return self;
}

//
//BNRItem Methods
//
- (void)removeItem:(BNRItem *)p
{
    
    NSString *key = [p imageKey];
    [[BNRImageStore defaultImageStore] deleteImageForKey:key];
    [_context deleteObject:p];
    [allItems removeObjectIdenticalTo:p];
}

- (NSArray *)allItems
{
    return allItems;
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    NSLog(@"To:   %d\nFrom: %d", to, from);
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    BNRItem *p = [allItems objectAtIndex:from];

    // Remove p from array
    [allItems removeObjectAtIndex:from];

    // Insert p in array at new location
    [allItems insertObject:p atIndex:to];
    
    // Computing a new orderValue for the object that was moved
    double lowerBound = 0.0;
    
    // Is there an object before it in the array?
    if(to > 0){
        lowerBound = [[allItems objectAtIndex:to -1] orderingValue];
    }else{
        lowerBound = [[allItems objectAtIndex:1] orderingValue] -2.0;
    }
    
    double upperBound = 0.0;
    
    // Is there an object after it in the array?
    if(to < [allItems count] -1){
        upperBound = [[allItems objectAtIndex:to +1] orderingValue];
    }else{
        upperBound = [[allItems objectAtIndex: to-1] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    NSLog(@"moving to order %f", newOrderValue);
    [p setOrderingValue:newOrderValue];
}

- (BNRItem *)createItem
{
    double order;
    if([allItems count] == 0){
        order = 1.0;
    }else{
        order = [[allItems lastObject] orderingValue] + 1.0;
    }
    NSLog(@"Adding after %d items, order = %.2f", [allItems count], order);
    
    BNRItem *p = [NSEntityDescription insertNewObjectForEntityForName:@"BNRItem"
                                            inManagedObjectContext:_context];
    [p setOrderingValue:order];
    [allItems addObject:p];
   
    return p;
}

- (BOOL) saveChanges{
    NSError *err = nil;
    BOOL successful = [_context save:&err];
    
    if(!successful){
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

-(NSString *)itemArchivePath{
    
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (void) loadAllItems{
    if(!allItems){
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[_model entitiesByName] objectForKey:@"BNRItem"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue"
                                                             ascending:YES];
        [request setSortDescriptors:@[sd]];
        
        NSError *error;
        NSArray *result = [_context executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"Fetch failed"
                        format:@"Reason:%@", [error localizedDescription]];
        }
        
        allItems = [[NSMutableArray alloc] initWithArray:result];
    }
}
//-----

//
//AssetType Methods
//
- (NSArray *) allAssetTypes{
    if(!_allAssetTypes){
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[_model entitiesByName] objectForKey:@"BNRAssetType"];
        [request setEntity:e];
        
        NSError *error;
        NSArray *result = [_context executeFetchRequest:request error:&error];
        if(!result){
            [NSException raise:@"Fetch Failed for allAssetTypes"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        _allAssetTypes = [result mutableCopy];
    }

    // Is this the first time the program is being run?
    if([_allAssetTypes count] == 0){
        NSManagedObject *type;
        
        NSArray *names = @[@"Furniture", @"Jewelry", @"Electronics", @"Miscellaneous"];
        
        for(NSString *s in names){
            type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                                 inManagedObjectContext:_context];
            
            [type setValue:s forKey:@"label"];
            [_allAssetTypes addObject:type];
        }
    }

    return _allAssetTypes;
}
//-----
@end
