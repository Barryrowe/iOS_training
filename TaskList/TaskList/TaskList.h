//
//  TaskList.h
//  TaskList
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskList : NSObject

@property NSString *path;
@property NSMutableArray *tasks;


- (TaskList *) initWithPath:(NSString *)p;

- (NSMutableArray *) loadTasksFromFile;

- (void) writeTasksToFile;

- (void) addTask:(Task *)t;
@end
