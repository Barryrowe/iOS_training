//
//  GHEvent.m
//  GitHubBrowser
//
//  Created by Admin on 3/7/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "GHEvent.h"

@implementation GHEvent

//
//Initializers
//
- (id) initWithNSDictionary:(NSDictionary *)dictFromJSON{
    self = [super init];
    if(self){   
        self.repoName = [dictFromJSON valueForKeyPath:@"repo.name"];
        self.repoURL = [dictFromJSON valueForKeyPath:@"repo.url"];
        self.userName = [dictFromJSON valueForKeyPath:@"actor.login"];
        
        NSString *details = @"Commit Details:\n";
        id commitData = [dictFromJSON valueForKeyPath:@"payload.commits"];
        if([commitData isKindOfClass:[NSArray class]]){
            for(id commit in commitData){
                if([commit isKindOfClass:[NSDictionary class]]){
                    details = [details stringByAppendingString:[commit valueForKeyPath:@"message"]];
                    details = [details stringByAppendingString:@"\n"];
                }
            }
        }else{
            details = [details stringByAppendingString:@" -- No Commit Messages --"];
        }
        
        self.details = details;
    }
    
    return self;
}

- (id) init{
    return [self initWithNSDictionary:nil];
}
//-----

- (NSString *) description{
    return [NSString stringWithFormat:@"%@ %@", self.repoName, self.userName];
}

//
//Instance Method Implementations
//
+ (NSArray *) eventsFromJSON:(NSData *)jsonData{
    NSError *parseError;
    id parsedObj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:0
                                                     error:&parseError];
    if(!parsedObj){
        NSLog(@"Error parsing JSON: %@", parseError);
        return nil;
    }
    
    if([parsedObj isKindOfClass:[NSArray class]]){
        NSArray *parsedEvents = (NSArray *)parsedObj;
        NSMutableArray *ghEvents = [[NSMutableArray alloc] initWithCapacity:[parsedEvents count]];
        
        for(id event in parsedEvents){
            if([event isKindOfClass:[NSDictionary class]]){
                GHEvent *newEvent = [[GHEvent alloc] initWithNSDictionary:event];
                [ghEvents addObject:newEvent];
            }
        }
        return ghEvents;
    }
    return nil;
}
//-----
@end
