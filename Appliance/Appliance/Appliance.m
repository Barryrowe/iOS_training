//
//  Appliance.m
//  Appliance
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "Appliance.h"

@implementation Appliance

@synthesize productName;
@synthesize voltage;

- (id)initWithProductName:(NSString *)pn
{
    self = [super init];
    if (self) {
        [self setProductName:pn];
        [self setVoltage:120];
    }
    return self;
}

- (id) init{
    return [self initWithProductName:@"Regla' Ass Toaster!"];
}

- (NSString *) description{
    return [NSString stringWithFormat:@"Name: %@\nVoltage: %d", [self productName], [self voltage]];
}
@end
