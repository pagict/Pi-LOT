//
//  PiWeiboDetailCommentTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 5/9/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiWeiboDetailCommentTableViewCell.h"

@interface PiWeiboDetailCommentTableViewCell ()
@property (strong, nonatomic) PiComment* commentMessage;

@property (strong, nonatomic) UIImageView* profileView;
@property (strong, nonatomic) UILabel* userNameLabel;
@property (strong, nonatomic) UILabel* commentTimeLabel;
@property (strong, nonatomic) UILabel* commentContentLabel;
@end

@implementation PiWeiboDetailCommentTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (instancetype)initWithMessage:(PiMessage *)message {
    if (self = [super init]) {
        if ([message isKindOfClass:[PiComment class]]) {
            self.commentMessage = (PiComment *)message;
            
            CGRect imageFrame = CGRectMake(10, 10, 45, 45);
            self.profileView = [[UIImageView alloc] initWithFrame:imageFrame];
            [self.contentView addSubview:self.profileView];

            CGRect userNameFrame = CGRectMake(65, 10, 220, 20);
            self.userNameLabel = [[UILabel alloc] initWithFrame:userNameFrame];
            [self.contentView addSubview:self.userNameLabel];

            CGRect commentTimeFrame = CGRectMake(65, 38, 220, 20);
            self.commentTimeLabel = [[UILabel alloc] initWithFrame:commentTimeFrame];
            [self.contentView addSubview:self.commentTimeLabel];

            CGRect contentFrame = CGRectMake(65, 65, 220, 0);
            self.commentContentLabel = [[UILabel alloc] initWithFrame:contentFrame];
            [self.contentView addSubview:self.commentContentLabel];
        }

    }
    return self;
}


- (void)setCell {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest
                                              requestWithURL:self.commentMessage.commentUser.profileImageURL]
                                       queue:[[NSOperationQueue alloc]
                                              init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               self.profileView.image = [UIImage imageWithData:data];
                           }];
    self.userNameLabel.text = self.commentMessage.commentUser.screenName;
    self.userNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.commentTimeLabel.text = self.commentMessage.commentTime;
    self.commentTimeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    self.commentContentLabel.attributedText = [[NSAttributedString alloc]
                                               initWithString:self.commentMessage.commentContent
                                               attributes:@{NSFontAttributeName:
                                                                [[UIFont preferredFontForTextStyle:UIFontTextStyleBody] fontWithSize:14]
                                                            }];
    CGRect updatingFrame = self.commentContentLabel.frame;
    updatingFrame.size.height = [self lineHeightOfLabel:self.commentContentLabel]*[self linesOfLabel:self.commentContentLabel];
    self.commentContentLabel.frame = updatingFrame;
    self.commentContentLabel.numberOfLines = 0;
}

- (CGFloat)height {
    return self.commentContentLabel.frame.origin.y + self.commentContentLabel.frame.size.height + 10;
}

@end
