//
//  BNRImageStore.m
//  Homepwner
//
//  Created by joeconway on 9/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BNRImageStore.h"
@interface BNRImageStore()
- (NSString *) imagePathForKey:(NSString *)key;
@end

@implementation BNRImageStore
+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultImageStore];
}

+ (BNRImageStore *)defaultImageStore
{
    static BNRImageStore *defaultImageStore = nil;
    if (!defaultImageStore) {
        // Create the singleton
        defaultImageStore = [[super allocWithZone:NULL] init];
    }
    return defaultImageStore;
}

- (id)init {
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    return self;
}

- (void) clearCache:(NSNotification *)note{
    NSLog(@"flushing %d images out of the cache", [dictionary count]);
    [dictionary removeAllObjects];
}

-(void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
    
    // Create full path for image
    NSString *imagePath = [self imagePathForKey:s];
    
    // Turn image into JPEG data
    //NSData *d = UIImageJPEGRepresentation(i, 0.5);
    NSData *d = UIImagePNGRepresentation(i);

    //Write file to full path
    [d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)s
{
    UIImage *i = [dictionary objectForKey:s];
    
    if(!i){
        // Create UIImage object from file
        i = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
        
        // If we found an image on the file system, place it into the cache
        if(i){
            [dictionary setObject:i forKey:s];
        }else{
            NSLog(@"Error: unable to find %@", [self imagePathForKey:s]);
        }
    }
    return i;
}

- (void)deleteImageForKey:(NSString *)s
{
    if(!s)
        return;
    [dictionary removeObjectForKey:s];
    
    //Get the full path for the image
    NSString *imagePath = [self imagePathForKey:s];
    
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    
}

- (NSString *) imagePathForKey:(NSString *)key{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                        NSUserDomainMask,
                                                                        YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end
