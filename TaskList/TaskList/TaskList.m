//
//  TaskList.m
//  TaskList
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "TaskList.h"

@interface TaskList()

@property NSMutableArray *tasks;
- (NSString *) storagePath;

@end

@implementation TaskList

- (id) init{
    self = [super init];
    if(self){
        [self loadTasksFromFile];
    }
    
    return self;
}

- (NSMutableArray *) loadTasksFromFile{

    [self setTasks:[NSKeyedUnarchiver unarchiveObjectWithFile:[self storagePath]]];
    
    if(![self tasks]){
        [self setTasks:[[NSMutableArray alloc] init]];
    }
    
    return [self tasks];
}

- (void) writeTasksToFile{    
    [NSKeyedArchiver archiveRootObject:[self tasks] toFile:[self storagePath]];
}

- (void) addTask:(Task *)t{
    [[self tasks] addObject:t];

    NSSortDescriptor *byDueDate = [NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES];
    [[self tasks] sortUsingDescriptors:@[byDueDate]];
}

- (NSString *) storagePath{
    return @"/tmp/tasks.archive";
//    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *path = [documentDirectories objectAtIndex:0];
//    
//    return [path stringByAppendingPathComponent:@"tasks.archive"];
}

- (NSArray *) currentTasks{
    return [[self tasks] copy];
}
@end
