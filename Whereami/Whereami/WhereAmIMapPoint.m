//
//  WhereAmIMapPoint.m
//  WhereAmI
//
//  Created by Admin on 3/4/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "WhereAmIMapPoint.h"

@implementation WhereAmIMapPoint

- (id) initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t{
    self = [super init];
    if(self){
        _coordinate = c;
        [self setTitle:t];
        
        //Get Date as string
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/yyyy HH:mm"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];

        [self setSubtitle:dateString];
    }
    return self;
}

- (id) init{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) title:@"Hometown"];
}
@end
