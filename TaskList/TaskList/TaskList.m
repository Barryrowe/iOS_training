//
//  TaskList.m
//  TaskList
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "TaskList.h"

@implementation TaskList

@synthesize path;
@synthesize tasks;

- (TaskList *) initWithPath:(NSString *)p{
    self = [super init];
    if(self){
        [self setPath:p];
        [self setTasks:[[NSMutableArray alloc] init]];
    }
    
    return self;
}

- (NSMutableArray *) loadTasksFromFile{
    NSMutableArray *dicTasks = [[NSMutableArray alloc] initWithContentsOfFile:[self path]];
    
    if(![self tasks]){
        [self setTasks:[[NSMutableArray alloc] init]];
    }
    
    for(NSDictionary *d in dicTasks){
        [[self tasks] addObject: [[Task alloc] initWithDueDate:d[@"Due Date"] andDescription:d[@"Description"]]];
    }
    
    
    return [self tasks];
}

- (void) writeTasksToFile{
    NSMutableArray *dictItems = [[NSMutableArray alloc] init];
    for(Task *t in [self tasks]){
        NSMutableDictionary *dicTask = [[NSMutableDictionary alloc] init];
        [dicTask setObject:t.dueDate forKey:@"Due Date"];
        [dicTask setObject:t.taskDescription forKey:@"Description"];
        [dictItems addObject:dicTask];
    }
    
    [dictItems writeToFile:[self path] atomically:YES];
}

- (void) addTask:(Task *)t{
    [[self tasks] addObject:t];

    NSSortDescriptor *byDueDate = [NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES];
    [[self tasks] sortUsingDescriptors:@[byDueDate]];
}
@end
