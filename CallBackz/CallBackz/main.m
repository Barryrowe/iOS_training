//
//  main.m
//  CallBackz
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logger.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {

        Logger *logga = [[Logger alloc] init];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:logga
                                       selector:@selector(sayOuch:)
                                       userInfo:@"message!!" repeats:YES];
        
//        NSURL *url = [NSURL URLWithString:@"http://www.gutenberg.org/cache/epub/205/pg205.txt"];
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        
//        [logga setCallWhenDone: @selector(sayOuch:)];
//        
//        __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request
//                                                                              delegate:logga
//                                                                      startImmediately:YES];
//        
//        
//        
//        [[NSNotificationCenter defaultCenter] addObserver:logga
//                                                 selector:@selector(zoneChange:)
//                                                     name:NSSystemTimeZoneDidChangeNotification
//                                                   object:nil];
        //Run Loops
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}

