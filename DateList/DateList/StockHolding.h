//
//  StockHolding.h
//  DateList
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockHolding : NSObject


@property (readonly) float purchaseSharePrice;
@property float currentSharePrice;
@property int numberOfShares;
@property (strong) NSString *symbol;

- (float)costInDollars;
- (float)valueInDollars;
- (float)earnings;
- (NSString *) description;

- (StockHolding *) initWithPurchasePrice:(float)psp;

+ (StockHolding *) generateHolding:(float)psp currentStockPrice:(float)csp numberOfShares:(int)n symbol:(NSString *)s;
@end
