//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore (){
    NSMutableArray *_allItems;
}
@end

@implementation BNRItemStore

@synthesize allItems = _allItems;

- (id) init{
    self = [super init];
    if(self){
        _allItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BNRItem *) createItem{
    BNRItem *p = [BNRItem randomItem];
    [_allItems addObject:p];
    
    return p;
}

- (void) removeItem:(BNRItem *)p{
    [_allItems removeObjectIdenticalTo:p];
}

- (void) movieItemAtIndex:(int)from toIndex:(int)to{
    if(from == to){ return;}
    
    // Get Pointer to boject being moved
    BNRItem *target = [_allItems objectAtIndex:from];
    [_allItems removeObjectAtIndex:from];
    
    [_allItems insertObject:target atIndex:to];
}

//
//Class Methods

+ (BNRItemStore *) sharedStore{
    static BNRItemStore *sharedStore = nil;
    
    if(!sharedStore){
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id) allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}
@end
