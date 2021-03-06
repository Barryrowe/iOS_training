//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Admin on 3/5/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject
{

}
// Notice that this is a class method and prefixed with a + instead of -
+ (BNRItemStore *) sharedStore;

@property (nonatomic, strong, readonly) NSArray *allItems;

- (BNRItem *) createItem;

- (void) removeItem:(BNRItem *)p;

- (void) movieItemAtIndex:(int)from toIndex:(int)to;

@end
