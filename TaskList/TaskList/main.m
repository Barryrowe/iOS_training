//
//  main.m
//  TaskList
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "TaskList.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        TaskList *myTasks = [[TaskList alloc] init];

        
        if(argc == 3){
            char *dueDate, *description;
            dueDate = argv[1];
            description = argv[2];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"mm/dd/yyyy HH:mm"];
            NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%s", dueDate]];
            
            NSString *desc = [NSString stringWithFormat:@"%s",description];
            
            Task *t = [[Task alloc] initWithDueDate:date andDescription:desc];
            [myTasks addTask:t];
            [myTasks writeTasksToFile];
        }else if(argc < 3){
            
            for(int i=0;i<10;i++){
                Task *task = [[Task alloc] initWithDueDate:[[NSDate date] dateByAddingTimeInterval:-24*60*60*i]
                                             andDescription:[NSString stringWithFormat:@"Task Number %d", i]];
                NSLog(@"Task %d: %@ - %@",i, [task dueDate], [task description]);
                
                [myTasks addTask:task];
                
                NSLog(@"List\n\n%@", [myTasks currentTasks]);
            }
            
            [myTasks writeTasksToFile];
            NSMutableArray *copyOfTasks = [myTasks loadTasksFromFile];
            NSLog(@"Tasks From File: %@", copyOfTasks);
        }
    }
    return 0;
}

