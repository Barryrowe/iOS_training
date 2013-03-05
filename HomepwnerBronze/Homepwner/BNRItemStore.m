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

- (NSArray *) sortByDescriptor:(NSSortDescriptor *)des{
    NSMutableArray *cpy = [NSMutableArray arrayWithArray:_allItems];
    [cpy sortUsingDescriptors:@[des]];
    return cpy;
}

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
