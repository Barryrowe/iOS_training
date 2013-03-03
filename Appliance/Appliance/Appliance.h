//
//  Appliance.h
//  Appliance
//
//  Created by Admin on 3/3/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appliance : NSObject

@property (copy) NSString *productName;
@property int voltage;

-(id) initWithProductName:(NSString *)pn;
@end
