//
//  StockHolding.m
//  DateList
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "StockHolding.h"

@implementation StockHolding

@synthesize purchaseSharePrice;
@synthesize currentSharePrice;
@synthesize numberOfShares;
@synthesize symbol;

- (float) costInDollars{
    return [self purchaseSharePrice] * [self numberOfShares];
}

- (float) valueInDollars{
    return [self currentSharePrice] * [self numberOfShares];
}

- (float) earnings{
    return [self valueInDollars] - [self costInDollars];
}

- (NSString *) description{
    return [NSString stringWithFormat:@"Stock %@ has CSP: $%6.2f and was purchased at $%6.2f", symbol, currentSharePrice , purchaseSharePrice ];
}

- (StockHolding *) initWithPurchasePrice:(float)psp{
    self = [super init];
    if(self){
        purchaseSharePrice = psp;
    }
    
    return self;
}

+ (StockHolding *) generateHolding:(float)psp currentStockPrice:(float)csp numberOfShares:(int)n symbol:(NSString *)s{
    StockHolding *h = [[StockHolding alloc] initWithPurchasePrice:psp];
    [h setCurrentSharePrice:csp];
    [h setNumberOfShares:n];
    [h setSymbol:s];
    return h;
}

@end
