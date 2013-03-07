//
//  GHEvent.h
//  GitHubBrowser
//
//  Created by Admin on 3/7/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHEvent : NSObject

@property (nonatomic, copy) NSString *repoName;
@property (nonatomic, copy) NSString *repoURL;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *details;
//
//Initializers
//
- (id) initWithNSDictionary:(NSDictionary *) dictFromJSON;
//-----

//
//Class Methods
//
+ (NSArray *) eventsFromJSON:(NSData *)jsonData;
//-----
@end
