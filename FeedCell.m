//
//  FeedCell.m
//  Instagram
//
//  Created by aaronm17 on 7/10/19.
//  Copyright © 2019 aaronm17. All rights reserved.
//

#import "FeedCell.h"
#import "Post.h"
#import "NSDate+DateTools.h"

@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCell: (Post *)post {
    _post = post;
    self.postImage.file = post.image;
    [self.postImage loadInBackground];
    self.postCaption.text = post.caption;
    self.numLikes.text = [post.likeCount stringValue];
    self.numComments.text = [post.commentCount stringValue];
    self.username.text = post.author.username;
    NSDate *createdAtDate = post.createdAt;
    NSDate *timeAgoDate = [NSDate dateWithTimeInterval:0 sinceDate:createdAtDate];
    self.createdAt.text = timeAgoDate.shortTimeAgoSinceNow;

}

- (IBAction)didTapLike:(UIButton *)sender {
    if (self.post.liked) {
        self.post.liked = NO;
        NSNumber *likeCountDecreased = [NSNumber numberWithInt:self.post.likeCount.intValue - 1];
        self.post.likeCount = likeCountDecreased;
        [self.likeButton setSelected:(NO)];
    } else {
        self.post.liked = YES;
        NSNumber *likeCountIncreased = [NSNumber numberWithInt:self.post.likeCount.intValue + 1];
        self.post.likeCount = likeCountIncreased;
        [self.likeButton setSelected:(YES)];
    }
    self.numLikes.text = [self.post.likeCount stringValue];
    [self.post saveInBackground];
}

- (IBAction)didTapComment:(UIButton *)sender {
    
}


@end
