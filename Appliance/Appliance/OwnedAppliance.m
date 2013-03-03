//
//  OwnedAppliance.m
//  Appliance
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "OwnedAppliance.h"

@implementation OwnedAppliance

- (id) initWithProductName:(NSString *)pn{
    return [self initWithProductName:pn firstOwnerName:nil];
}

- (id) initWithProductName:(NSString *)pn firstOwnerName:(NSString *)n{
    self = [super initWithProductName:pn];
    if(self){
        ownerNames = [[NSMutableSet alloc] init];
        if(n){
            [ownerNames addObject:n];
        }
    }
    
    return self;
}
- (void) addOwnerNamesObject:(NSString *)n{
    if(n && ownerNames){
        [ownerNames addObject:n];
    }
}
- (void) removeOwnerNamesObject:(NSString *)n{
    if(n && ownerNames){
        [ownerNames removeObject:n];
    }
}

@end
