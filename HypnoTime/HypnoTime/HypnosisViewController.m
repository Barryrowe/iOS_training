//
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Admin on 3/4/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@implementation HypnosisViewController

- (id) initWithNibName:(NSString *)nibNameOrNil
                bundle:nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        // Get the Tab Bar Items
        UITabBarItem *tbi = [self tabBarItem];
        
        //Give it a label
        [tbi setTitle:@"Hypnosis"];
        
        // Create a UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        // Put that image on the tab bar item
        [tbi setImage:i];
    }
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    NSLog(@"HypnosisViewController loaded its view.");
}

- (void) loadView{
    //Create a View
    CGRect frame = [[UIScreen mainScreen] bounds];
    HypnosisView *v = [[HypnosisView alloc] initWithFrame:frame];
    
    // Set it as the view of this view controller
    [self setView:v];
    
}
@end
