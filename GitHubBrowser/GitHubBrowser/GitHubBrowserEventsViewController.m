//
//  GitHubBrowserFirstViewController.m
//  GitHubBrowser
//
//  Created by Admin on 3/7/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "GitHubBrowserEventsViewController.h"
#import "GHEvent.h"

@interface GitHubBrowserEventsViewController ()
@property (nonatomic, strong) NSArray *ghEvents;

- (void) refreshEvents;
@end

@implementation GitHubBrowserEventsViewController

@synthesize ghEvents = _ghEvents;
@synthesize eventTable = _eventTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Events";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
//        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"gh_events" ofType:@"json"];
//        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
//        _ghEvents = [GHEvent eventsFromJSON:jsonData];
    }
    return self;
}

#pragma mark - Table View
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.ghEvents count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[self.ghEvents objectAtIndex:[indexPath row]] description];
    cell.detailTextLabel.text = [[self.ghEvents objectAtIndex:[indexPath row]] details];
    return cell;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshEvents{
    // Use the GitHub API!
    NSString *ghEventsAPIURL = @"https://api.github.com/events";
    
    NSURL *url = [[NSURL alloc] initWithString:ghEventsAPIURL];
    NSMutableURLRequest *newReq = [[NSMutableURLRequest alloc] initWithURL:url];
    [newReq setValue:@"NO-CACHE" forHTTPHeaderField:@"Cache-control"];
    
    void (^handler)(NSURLResponse *urlResponse, NSData *responseData, NSError *error) =
    ^(NSURLResponse *urlResponse, NSData *responseData, NSError *error){
        if([urlResponse isKindOfClass:[NSHTTPURLResponse class]]){
            NSDictionary *headers = [(NSHTTPURLResponse *)urlResponse allHeaderFields];
            NSString *rateLimit = headers[@"X-RateLimit-Limit"];
            NSString *callsLeft = headers[@"X-RateLimit-Remaining"];
            NSLog(@"%@ of %@ calls remaining", callsLeft, rateLimit);
        }
        self.ghEvents = [GHEvent eventsFromJSON:responseData];
        [self.eventTable reloadData];
    };
    
    [NSURLConnection sendAsynchronousRequest:newReq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:handler];
}

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshEvents];
}

@end
