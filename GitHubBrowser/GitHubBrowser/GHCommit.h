//
//  GHCommit.h
//  GitHubBrowser
//
//  Created by Admin on 3/7/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHCommit : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *commitKey;

- (id) initWithNSDictionary:(NSDictionary *) dictFromJSON;

+ (NSArray *) eventsFromJSON:(NSData *)jsonData;
@end
