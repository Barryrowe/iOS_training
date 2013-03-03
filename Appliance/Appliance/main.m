//
//  main.m
//  Appliance
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appliance.h"
#import "OwnedAppliance.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Appliance *a = [[Appliance alloc] init];
        NSLog(@"A is %@", a);
        
        Appliance *b = [[Appliance alloc] initWithProductName:@"Sweet Ass Fridge!"];
        NSLog(@"B is %@", b);
        
        
        OwnedAppliance *oa = [[OwnedAppliance alloc] initWithProductName:@"Boss MF'in Dryer" firstOwnerName:@"Barry Rowe"];
        
        NSLog(@"A2: %@", oa);
        
        OwnedAppliance *oa2 = [[OwnedAppliance alloc] initWithProductName:@"Garbage King 5000"];
        NSLog(@"A3: %@", oa2);
        [oa2 addOwnerNamesObject:@"Barry Rowe"];
    }
    return 0;
}

