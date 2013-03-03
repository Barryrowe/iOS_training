//
//  Logger.h
//  CallBackz
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject <NSURLConnectionDataDelegate>{
    NSMutableData *incomingData;
}

- (void) sayOuch:(NSTimer *)t;

@property SEL callWhenDone;

@end
