//
//  Task.m
//  TaskList
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize dueDate;
@synthesize taskDescription;

- (Task *) initWithDueDate:(NSDate *)d andDescription:(NSString *)desc{
    NSLog(@"Date: %@ and Desc: %@", d, desc);
    self = [super init];
    if(self){
        [self setDueDate:d];
        [self setTaskDescription:desc];
    }
    
    return self;
}

- (NSString *) description{
    NSString *result = [NSString stringWithFormat:@"Due Date: %@\nDescription: %@", [self dueDate], [self taskDescription]];
    return result;
}
@end
