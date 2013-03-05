//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore(){
    NSMutableDictionary *_dictionary;
}
@end

@implementation BNRImageStore

#pragma Singleton Implementation
//
//Singleton Implementation
//
+ (id) allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}

+ (BNRImageStore *)sharedStore{
    static BNRImageStore *sharedStore = nil;
    if(!sharedStore){
        sharedStore = [[super allocWithZone:NULL] init];
    }
    
    return sharedStore;
}
//-----

#pragma Basic Class Inits
//
//Basic Class Inits
//
- (id)init
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}
//-----

#pragma Custom Implementations
//
//Custome Implementations
//
- (void) setImage:(UIImage *)i forKey:(NSString *)s{
    [_dictionary setObject:i forKey:s];
}

- (UIImage *) imageForKey:(NSString *)s{
    return [_dictionary objectForKey:s];
}

- (void) deleteImageForKey:(NSString *)s{
    if(!s)
        return;
    
    [_dictionary removeObjectForKey:s];
}
//-----
@end
