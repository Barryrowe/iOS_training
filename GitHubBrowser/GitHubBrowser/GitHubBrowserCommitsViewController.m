//
//  GitHubBrowserSecondViewController.m
//  GitHubBrowser
//
//  Created by Admin on 3/7/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import "GitHubBrowserCommitsViewController.h"
#import "GHCommit.h"

@interface GitHubBrowserCommitsViewController ()

@property (nonatomic, strong) NSArray *commits;

- (void) refreshData;

@end

@implementation GitHubBrowserCommitsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"My Commits";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
        
    }
    return self;
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

- (void) refreshData{
    // Use the GitHub API!
    NSString *ghEventsAPIURL = @"https://api.github.com/repos/Barryrowe/iOS_Training/commits";
    
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
        self.commits = [GHCommit eventsFromJSON:responseData];
        [self.commitsTable reloadData];
    };
    
    [NSURLConnection sendAsynchronousRequest:newReq
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:handler];
}
//
//UITableViewDataSource
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self commits] count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[self.commits objectAtIndex:[indexPath row]] description];
    cell.detailTextLabel.text = [[self.commits objectAtIndex:[indexPath row]] detail];
    return cell;
}


//-----

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshData];
}

@end
