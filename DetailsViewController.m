//
//  DetailsViewController.m
//  Instagram
//
//  Created by aaronm17 on 7/11/19.
//  Copyright © 2019 aaronm17. All rights reserved.
//

#import "DetailsViewController.h"
#import "FeedViewController.h"
#import "Post.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.postImage.file = self.post.image;
    self.username.text = self.post.author.username;
    self.caption.text = self.post.caption;
    self.likeCount.text = [self.post.likeCount stringValue];
    self.commentCount.text = [self.post.commentCount stringValue];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
