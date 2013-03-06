//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Admin on 3/6/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

//
//UIViewController Implementations
//
- (void) loadView{
    [self setView:[[BNRDrawView alloc] initWithFrame:CGRectZero]];
}
//-----

@end
