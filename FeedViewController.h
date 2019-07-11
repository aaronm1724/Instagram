//
//  FeedViewController.h
//  Instagram
//
//  Created by aaronm17 on 7/9/19.
//  Copyright © 2019 aaronm17. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController

@property (strong, nonatomic) NSArray *displayedPosts;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

NS_ASSUME_NONNULL_END
