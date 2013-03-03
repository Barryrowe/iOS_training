//
//  Logger.m
//  CallBackz
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "Logger.h"

@implementation Logger

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"received %lu bytes", [data length]);
    
    //Create a mutable data if it doesn't already exist
    if(!incomingData){
        incomingData = [[NSMutableData alloc] init];
    }
    
    [incomingData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Fetched ALL THE DATA!!!");
    
    NSString *string = [[NSString alloc] initWithData:incomingData
                                             encoding:NSUTF8StringEncoding];
    
    incomingData = nil;
    NSLog(@"string has %lu characters", [string length]);
    //Uncomment out to see the whle book
    //NSLog(@"The Whole string is %@", string);
    
    //Call the Selector
    if([self callWhenDone]){
        [self performSelector:[self callWhenDone] withObject:nil];
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection failed: %@", [error localizedDescription]);
    incomingData = nil;
}

- (void) zoneChange:(NSNotification *)note{
    NSLog(@"The system Time Zone has Changed: %@", [note description]);
}

- (void) sayOuch:(NSTimer *)t{
    static int count = 0;
    NSLog(@" Count is %d Ouch! at %@ and %@",count, t, [t userInfo]);
    if(count++==5 && t){
        //turn it off
        [t invalidate];
    }    
}
@end
