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

//
//NSCoding IMplementation
//

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        [self setDueDate:[aDecoder decodeObjectForKey:@"dueDate"]];
        [self setTaskDescription:[aDecoder decodeObjectForKey:@"taskDescription"]];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[self dueDate] forKey:@"dueDate"];
    [aCoder encodeObject:[self taskDescription] forKey:@"taskDescription"];
}
//-----
@end
