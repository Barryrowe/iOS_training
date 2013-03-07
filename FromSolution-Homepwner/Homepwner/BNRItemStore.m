//
//  BNRItemStore.m
//  Homepwner
//
//  Created by joeconway on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore()
- (NSString *)itemArchivePath;
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
        NSString *path = [self itemArchivePath];
        allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

        // If the array hadn't been saved previously lets build a new empty
        //  set of items
        if(!allItems){
            allItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)removeItem:(BNRItem *)p
{
    
    NSString *key = [p imageKey];
    [[BNRImageStore defaultImageStore] deleteImageForKey:key];
    
    [allItems removeObjectIdenticalTo:p];
}

- (NSArray *)allItems
{
    return allItems;
}

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to
{
    if (from == to) {
        return;
    }
    // Get pointer to object being moved so we can re-insert it
    BNRItem *p = [allItems objectAtIndex:from];

    // Remove p from array
    [allItems removeObjectAtIndex:from];

    // Insert p in array at new location
    [allItems insertObject:p atIndex:to];
}

- (BNRItem *)createItem
{
    BNRItem *p = [[BNRItem alloc] init];

    [allItems addObject:p];
   
    return p;
}

- (BOOL) saveChanges{
    // returns success or failure
    NSString *path = [self itemArchivePath];
    
    NSLog(@"Archive at: %@", path);
    return [NSKeyedArchiver archiveRootObject:allItems
                                       toFile:path];
}
-(NSString *)itemArchivePath{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}
@end
