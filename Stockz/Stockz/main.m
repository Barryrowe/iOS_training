//
//  main.m
//  Stockz
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSMutableArray *stocks = [[NSMutableArray alloc] init];
        NSMutableDictionary *stock = [NSMutableDictionary dictionary];
        
        stock[@"symbol"] =@"AAPL";
        stock[@"shares"] =@200;
        [stocks addObject:stock];

        NSMutableDictionary *stock2 = [NSMutableDictionary dictionary];
        stock2[@"symbol"] = @"HP";
        stock2[@"shares"] = @500;
        
        [stocks addObject:stock2];
        
        [stocks writeToFile:@"/tmp/stocks.plist" atomically:YES];
        
        stocks = [NSArray arrayWithContentsOfFile:@"/tmp/stocks.plist"];
        
        NSLog(@"PLIST CONTENTS:\n %@", stocks);
        
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:stocks options:0 error:&error];
        [data writeToFile:@"/tmp/stocks.json" atomically:YES];
        
    }
    return 0;
}

