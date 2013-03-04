//
//  TimeViewController.m
//  HypnoTime
//
//  Created by Admin on 3/4/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController()

@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
- (IBAction)showCurrentTime:(id)sender;

@end

@implementation TimeViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        UIImage *i = [UIImage imageNamed:@"Time.png"];

        //Get the UI Tab Bar Item
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Time"];
        [tbi setImage:i];
    }
    
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"TimeViewController Loaded its view!!");
    
    NSLog(@"timeLabel = %@", [self timeLabel]);
    [[self timeLabel] setBackgroundColor:[UIColor redColor]];
}

- (IBAction) showCurrentTime:(id)sender {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [[self timeLabel] setText:[formatter stringFromDate:now]];
}

@end
