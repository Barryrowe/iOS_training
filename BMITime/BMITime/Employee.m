//
//  Employee.m
//  BMITime
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "Employee.h"

@implementation Employee
@synthesize employeeID;
- (float) bodyMassIndex{
    float normalBMI = [super bodyMassIndex];
    float betterBMI = 0.9 * normalBMI;
    return betterBMI;
}

- (NSString *) description{
    NSString *pDesc = [super description];
    
    return [NSString stringWithFormat:@"%@ EmployeeID=%d", pDesc, [self employeeID]];
}

@end
