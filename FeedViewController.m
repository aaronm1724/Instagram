//
//  FeedViewController.m
//  Instagram
//
//  Created by aaronm17 on 7/9/19.
//  Copyright © 2019 aaronm17. All rights reserved.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ComposeViewController.h"
#import "FeedCell.h"
#import "Post.h"
#import "DetailsViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 400;
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(beginRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self fetchPosts];
}


- (IBAction)didTapLogout:(UIBarButtonItem *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // current user will now be nil
        AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        appDelegate.window.rootViewController = loginViewController;
    }];
}

-(void)fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.displayedPosts = [[NSMutableArray alloc] initWithArray:posts] ;
            [self.tableView reloadData];
            
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh {
    [self fetchPosts];
    [self.refreshControl endRefreshing];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:@"detailsSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        tappedCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        Post *currentPost = self.displayedPosts[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.post = currentPost;
        tappedCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedCell *feedCell = [self.tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    
    [feedCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    Post *post = self.displayedPosts[indexPath.row];
    
    feedCell.post = post;
    [feedCell setCell:post];
    return feedCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayedPosts.count;
}



@end
