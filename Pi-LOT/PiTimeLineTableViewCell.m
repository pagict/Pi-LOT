//
//  PiTimeLineTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTimeLineTableViewCell.h"

@interface PiTimeLineTableViewCell ()
@property (strong, nonatomic) UIImageView *profileImageView;
@property (strong, nonatomic) UILabel *userNameField;
@property (strong, nonatomic) UILabel *sourceField;
@property (strong, nonatomic) UILabel *tweetTimeField;
@property (strong, nonatomic) UILabel *tweetView;
@property (strong, nonatomic) UILabel *repostCntField;
@property (strong, nonatomic) UILabel *commentsCntField;

@end

@implementation PiTimeLineTableViewCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)init {
    if (self = [super init]) {
        CGRect imageFrame = CGRectMake(20, 10, 52, 53);
        self.profileImageView = [[UIImageView alloc] initWithFrame:imageFrame];
        [self.contentView addSubview:self.profileImageView];

        CGRect userFrame = CGRectMake(80, 10, 220, 30);
        self.userNameField = [[UILabel alloc] initWithFrame:userFrame];
        self.userNameField.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.userNameField];

        self.sourceField = [[UILabel alloc] initWithFrame:CGRectMake(80, 45, 86, 17)];
        self.sourceField.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.sourceField];

        self.tweetTimeField = [[UILabel alloc] initWithFrame:CGRectMake(174, 45, 126, 17)];
        self.tweetTimeField.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.tweetTimeField];

        self.tweetView = [[UILabel alloc] initWithFrame:CGRectMake(20, 71, 280, 240)];
        self.tweetView.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.tweetView];

        self.commentsCntField = [[UILabel alloc] initWithFrame:CGRectMake(113, 319, 94, 22)];
        self.commentsCntField.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.commentsCntField];

        self.repostCntField = [[UILabel alloc] initWithFrame:CGRectMake(215, 319, 85, 22)];
        self.repostCntField.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.repostCntField];
    }
    return self;
}

- (void)setCellFrom:(PiMessage*)message {
    PiTweet* tweet = (PiTweet*)message;
    self.userNameField.text = tweet.user.screenName;
    self.tweetTimeField.text = tweet.createTime;
    self.sourceField.text = tweet.source;

//    ((UITextView*)(self.tweetView)).text = tweet.text;
//    self.tweetView.frame.size.height = self.textHeight;
    self.tweetView.text = tweet.text;
    CGRect frame = self.tweetView.frame;
    int tweetViewLines = [self linesOfLabel:self.tweetView];
    self.tweetView.numberOfLines = tweetViewLines;
    self.tweetView.lineBreakMode = NSLineBreakByTruncatingMiddle;
    frame.size.height = [self lineHeightOfLabel:self.tweetView] * tweetViewLines;
    self.tweetView.frame = frame;
    [self.tweetView sizeToFit];

    CGRect repostFrame = self.repostCntField.frame;
    repostFrame.origin.y = frame.origin.y + frame.size.height + 10;
    self.repostCntField.frame = repostFrame;
    self.repostCntField.text = [NSString stringWithFormat:@"转发(%d)", tweet.repostCount];

    CGRect commentFrame = self.commentsCntField.frame;
    commentFrame.origin.y = repostFrame.origin.y;
    self.commentsCntField.frame = commentFrame;
    self.commentsCntField.text = [NSString stringWithFormat:@"评论(%d)", tweet.commentCount];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:tweet.user.profileImageURL]
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               UIImage *img = [UIImage imageWithData:data];
                               self.profileImageView.contentMode = UIViewContentModeScaleToFill;
                               self.profileImageView.image = img;
                           }];

    
}
//
//- (CGFloat)textHeight {
//    NSDictionary *attri = [self.tweetView.attributedText attributesAtIndex:0
//                                                            effectiveRange:nil];
//
//    CGSize fontSize = [self.tweetView.text sizeWithAttributes:attri];
//    int charactersEachLine = self.tweetView.frame.size.width /*label width */ / (fontSize.width / self.tweetView.text.length);
//    int lines = self.tweetView.text.length / charactersEachLine + 1;
//
//    return lines*fontSize.height/* font height*/;
//}



- (CGFloat)height {
//    CGFloat otherComponentHeight = 353 - 240;
//    return otherComponentHeight + self.textHeight;
    return self.commentsCntField.frame.origin.y + self.commentsCntField.frame.size.height + 10;

}

@end
