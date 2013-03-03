//
//  Person.h
//  BMITime
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property float heightInMeters;
@property int weightInKilos;

//NOTE:  The properties above subvert the need for the
//          following boilerplate code.
//- (void) setHeightInMeters:(float)h;
//- (float) heightInMeters;
//- (void) setWeightInKilos:(int)w;
//- (int) weightInKilos;

- (float) bodyMassIndex;
- (NSString *) description;

+ (Person *) genericPerson;
@end
