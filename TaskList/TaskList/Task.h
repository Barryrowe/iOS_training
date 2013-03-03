//
//  Task.h
//  TaskList
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property NSDate *dueDate;
@property NSString *taskDescription;

- (Task *) initWithDueDate:(NSDate *)d andDescription:(NSString *)desc;
- (NSString *) description;
@end
