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
//    self.tweetView.frame.size.height = self.textHeight;
    self.tweetView.text = tweet.text;
    CGRect frame = self.tweetView.frame;
    frame.size.height = self.textHeight;
    self.tweetView.frame = frame;
    self.repostCntField.text = [NSString stringWithFormat:@"转发(%d)", tweet.repostCount];
    self.commentsCntField.text = [NSString stringWithFormat:@"评论(%d)", tweet.commentCount];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:tweet.user.profileImageURL]
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               UIImage *img = [UIImage imageWithData:data];
                               self.profileImageView.contentMode = UIViewContentModeScaleToFill;
                               self.profileImageView.image = img;
                           }];

    
}

- (CGFloat)textHeight {
    NSDictionary *attri = [self.tweetView.attributedText attributesAtIndex:0
                                                            effectiveRange:NULL];

    CGSize fontSize = [self.tweetView.text sizeWithAttributes:attri];
    int charactersEachLine = 280/*label width */ / (fontSize.width / self.tweetView.text.length);
    int lines = self.tweetView.text.length / charactersEachLine + (self.tweetView.text.length % charactersEachLine?1:0);

    return lines*fontSize.height/* font height*/;
}

- (CGFloat)height {
    CGFloat otherComponentHeight = 353 - 240;
    return otherComponentHeight + self.textHeight;
}

@end
