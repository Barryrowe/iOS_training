//
//  GitHubBrowserSecondViewController.h
//  GitHubBrowser
//
//  Created by Admin on 3/7/13.
//  Copyright (c) 2013 com.hp.es.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GitHubBrowserCommitsViewController : UIViewController <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *commitsTable;

@end
