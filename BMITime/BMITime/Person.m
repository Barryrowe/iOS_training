//
//  Person.m
//  BMITime
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize heightInMeters;
@synthesize weightInKilos;

//NOTE: The synthesize methods above subvert the need for
//          the following boilerplate code
//
//- (void) setHeightInMeters:(float)h{
//    heightInMeters = h;
//}
//
//- (float) heightInMeters{
//    return heightInMeters;
//}
//- (void) setWeightInKilos:(int)w{
//    weightInKilos = w;
//}
//
//- (int) weightInKilos{
//    return weightInKilos;
//}

- (float) bodyMassIndex{
    return [self weightInKilos]/([self heightInMeters]*[self heightInMeters]);
}

- (NSString *) description{
    return [NSString stringWithFormat:@"Height=%f Weight=%d", heightInMeters, weightInKilos];
}

+ (Person *) genericPerson{
    Person *p = [[Person alloc] init];
    [p setHeightInMeters:2.5];
    [p setWeightInKilos:65];
    
    return p;
}
@end
