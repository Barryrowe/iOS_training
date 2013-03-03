//
//  main.m
//  TimeAfterTime
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    
    @autoreleasepool {
        
        //[Message Sends]
        NSDate *now = [NSDate date];
        
        
        NSLog(@"The time is at %p", now);
        NSLog(@"The time is %@", now);
        
        double seconds = [now timeIntervalSince1970];
        NSLog(@"Seconds since 1970 %f", seconds);
        
        seconds = [now timeIntervalSince1970];
        NSLog(@"Seconds since 1970 %f", seconds);
        
        
        NSDate *later = [now dateByAddingTimeInterval:60.0*60.0];
        NSLog(@"Seconds since 1970 In an Hour: %f", [later timeIntervalSince1970]);
        
        
        //From Chapter 12
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setTimeZone:[[NSTimeZone alloc] initWithName:@"GMT -5:00"]];
        [comps setYear:1986];
        [comps setMonth:4];
        [comps setDay:7];
        [comps setHour:6];
        [comps setMinute:0];
        [comps setSecond:0];
        
        NSCalendar *gregCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *dob = [gregCalendar dateFromComponents:comps];
        NSLog(@"I've been alive %e seconds.", [now timeIntervalSinceDate:dob]);
        
        
        //From Chapter 13
        NSTimeZone *systemTZ = [NSTimeZone systemTimeZone];
        BOOL isDLST = [systemTZ isDaylightSavingTime];
        NSString *str = @"The System Time Zone says it %@ DaylightSavings";
        NSLog(str, isDLST ? @"is":@"is not");
        
        
        //From Chapter 14
        NSHost *myHost = [NSHost currentHost];        
        NSString *hostStr = @"My Host Name is %@";
        NSLog(hostStr, [myHost localizedName]);
        
        NSLog(@"The current directory path is %@", [[NSFileManager defaultManager] currentDirectoryPath]);
    }
    return 0;
}

