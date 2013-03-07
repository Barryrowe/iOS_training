//
//  GHCommit.m
//  GitHubBrowser
//
//  Created by Admin on 3/7/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "GHCommit.h"

@implementation GHCommit

-(id) initWithNSDictionary:(NSDictionary *)dictFromJSON{
    self = [super init];
    if(self){
        self.userName = [dictFromJSON valueForKeyPath:@"commit.committer.name"];
        self.commitKey = [dictFromJSON valueForKeyPath:@"sha"];
        self.detail = [dictFromJSON valueForKeyPath:@"commit.message"];
    }

    return self;
}

- (id) init{
    return [self initWithNSDictionary:nil];
}

- (NSString *) description{
    return [NSString stringWithFormat:@"%@ %@", self.userName, self.detail];
}

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
        NSMutableArray *ghCommits = [[NSMutableArray alloc] initWithCapacity:[parsedEvents count]];
        
        for(id event in parsedEvents){
            if([event isKindOfClass:[NSDictionary class]]){
                GHCommit *newEvent = [[GHCommit alloc] initWithNSDictionary:event];
                [ghCommits addObject:newEvent];
            }
        }
        return ghCommits;
    }
    return nil;
}

@end
