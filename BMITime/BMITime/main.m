//
//  main.m
//  BMITime
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Employee.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Person *me = [[Person alloc] init];
        [me setWeightInKilos:65];
        [me setHeightInMeters:2.6];
        
        NSLog(@"My BMI is %f", [me bodyMassIndex]);
        
        Person *generic = [Person genericPerson];
        
        NSLog(@"Generic person weighs %d kilos and is %f inches tall. His BMI is %f", [generic weightInKilos], [generic heightInMeters], [generic bodyMassIndex]);
        
        
        
        Employee *emp1 = [[Employee alloc] init];
        [emp1 setHeightInMeters:2.8];
        [emp1 setWeightInKilos:68];
        [emp1 setEmployeeID:22];
        
        Employee *emp2 = [[Employee alloc] init];
        [emp2 setHeightInMeters:2.8];
        [emp2 setWeightInKilos:68];
        [emp2 setEmployeeID:22];
        
        Employee *emp3 = [[Employee alloc] init];
        [emp3 setHeightInMeters:2.8];
        [emp3 setWeightInKilos:68];
        [emp3 setEmployeeID:101];
        
        //Chapter 21 Examples
        NSMutableArray *employees = [NSMutableArray arrayWithObjects:emp1, nil];
        [employees addObject:emp2];
        [employees addObject:emp3];
        
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"employeeID > 100"];
        NSArray *recentEmployees = [employees filteredArrayUsingPredicate:predicate];
        NSLog(@"%@", recentEmployees);
        
        NSSortDescriptor *byID = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
        [employees sortUsingDescriptors:@[byID]];
        
        for(Employee *e in employees){
            NSLog(@"%@", [e description]);
        }
    }
    return 0;
}

