//
//  OwnedAppliance.h
//  Appliance
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "Appliance.h"

@interface OwnedAppliance : Appliance{
    NSMutableSet *ownerNames;
}

- (id) initWithProductName:(NSString *)pn;
- (id) initWithProductName:(NSString *)pn firstOwnerName:(NSString *)n;
- (void) addOwnerNamesObject:(NSString *)n;
- (void) removeOwnerNamesObject:(NSString *)n;

@end
