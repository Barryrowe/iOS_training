//
//  BNRItemStore.h
//  Homepwner
//
//  Created by joeconway on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

//
//Class Level Methods
//
+ (BNRItemStore *)sharedStore;
//-----

//
//BNRItem Methods
//
- (void)removeItem:(BNRItem *)p;

- (NSArray *)allItems;

- (BNRItem *)createItem;

- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (BOOL) saveChanges;
//-----

//
//AssetType Methods
//
- (NSArray *) allAssetTypes;
//-----
@end
