//
//  main.m
//  DateList
//
//  Created by Admin on 3/2/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockHolding.h"



int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDate *now = [NSDate date];
        NSDate *later = [now dateByAddingTimeInterval:60.0*60];
        NSDate *earlier = [now dateByAddingTimeInterval:-60.0*60];
        
        NSArray *dateList = [NSArray arrayWithObjects:now, later, earlier, nil];
        
        NSLog(@"There are %lu objects in my dateList.", [dateList count]);
        NSLog(@"My Date List: %@", dateList);
        
        
        NSMutableArray *dateListMutable = [NSMutableArray arrayWithObjects:now, later, earlier, nil];
        
        NSLog(@"There are %lu objects in my mutable dateList.", [dateListMutable count]);
        NSLog(@"My Mutable Date List: %@", dateListMutable);
        
        [dateListMutable insertObject:[now dateByAddingTimeInterval:60.0*60*24] atIndex:0];
        
        NSLog(@"There are %lu objects in my mutable dateList.", [dateListMutable count]);
        NSLog(@"My Mutable Date List: %@", dateListMutable);
        
        //Challenge from Chapter 17
        StockHolding *h1 = [StockHolding generateHolding:14.5 currentStockPrice:15.5 numberOfShares:25  symbol:@"APL"];
        StockHolding *h2 = [StockHolding generateHolding:109.99 currentStockPrice:104.99 numberOfShares:400  symbol:@"PH"];
        StockHolding *h3 = [StockHolding generateHolding:500.43 currentStockPrice:649.99 numberOfShares:14 symbol:@"HP"];
                            
        
        NSArray *holdings = @[h1, h2, h3];
        
        for(int i=0;i<[holdings count];i++){
            NSLog(@"Holding %d has %d units with CSP: %f PSP: %f ", i, [holdings[i] numberOfShares], [holdings[i] currentSharePrice], [holdings[i] purchaseSharePrice]);
            NSLog(@"The Cost was: $%6.2f", [holdings[i] costInDollars]);
            NSLog(@"The Value is: $%6.2f", [holdings[i] valueInDollars]);
            NSLog(@"This holding has gained: $%6.2f", [holdings[i] earnings]);
        }
        
        NSPredicate *p = [NSPredicate predicateWithFormat:@"symbol ENDSWITH \"H\""];
        NSLog(@"stocks ending in H: %@", [holdings filteredArrayUsingPredicate:p]);
        
        NSDictionary *d = [NSDictionary dictionaryWithObjects:@[@"apple", @"banana", @"cookie"]
                                                      forKeys:@[@"a", @"b", @"c"]];
        NSDictionary *dLiteral = @{@"A":@"apples",
                                   @"B":@"bananas",
                                   @"C":@"cookies"};
        
        NSLog(@"A is for %@", [d objectForKey:@"a"]);
        NSLog(@"A is for %@", [dLiteral objectForKey:@"a"]);
        
        NSNumber *n = [NSNumber numberWithInt:5];
        NSLog(@"Our number is %@", n);
    }
    return 0;
}

