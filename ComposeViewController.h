//
//  ComposeViewController.h
//  Instagram
//
//  Created by aaronm17 on 7/10/19.
//  Copyright © 2019 aaronm17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postedImage;
@property (weak, nonatomic) IBOutlet UITextView *postedCaption;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
