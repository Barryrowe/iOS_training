//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (BNRImageStore *) sharedStore;

- (void) setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *) imageForKey:(NSString *)s;
- (void) deleteImageForKey:(NSString *)s;
@end
