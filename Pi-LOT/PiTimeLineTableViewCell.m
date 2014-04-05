//
//  PiTimeLineTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTimeLineTableViewCell.h"

@interface PiTimeLineTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *userNameField;
@property (weak, nonatomic) IBOutlet UILabel *sourceField;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeField;
@property (weak, nonatomic) IBOutlet UILabel *tweetView;
@property (weak, nonatomic) IBOutlet UILabel *repostCntField;
@property (weak, nonatomic) IBOutlet UILabel *commentsCntField;

@end

@implementation PiTimeLineTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellFrom:(PiTweet*)tweet {
    self.userNameField.text = tweet.user.screenName;
    self.tweetTimeField.text = tweet.createTime;
    self.sourceField.text = tweet.source;

//    ((UITextView*)(self.tweetView)).text = tweet.text;
    self.tweetView.text = tweet.text;
    self.repostCntField.text = [NSString stringWithFormat:@"reposts(%d)", tweet.repostCount];
    self.commentsCntField.text = [NSString stringWithFormat:@"comments(%d)", tweet.commentCount];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:tweet.user.profileImageURL]
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               self.imageView.image = [UIImage imageWithData:data];
                           }];

    
}

@end
