//
//  PiTweetDetailCommentTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 5/9/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTweetDetailCommentTableViewCell.h"

@interface PiTweetDetailCommentTableViewCell ()
@property (strong, nonatomic) UIImageView* profileView;
@property (strong, nonatomic) UILabel* userNameLabel;
@property (strong, nonatomic) UILabel* commentTimeLabel;
@property (strong, nonatomic) UILabel* commentContentLabel;

@property (weak, nonatomic) PiComment* message;
@end

@implementation PiTweetDetailCommentTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (instancetype)initWithMessage:(PiMessage *)message {
    if (self = [super initWithMessage:message]) {
        if ([message isKindOfClass:[PiComment class]]) {
            self.message = (PiComment *)message;
            
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


- (void)updateCell {
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest
                                              requestWithURL:self.message.commentUser.profileImageURL]
                                       queue:[[NSOperationQueue alloc]
                                              init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               self.profileView.image = [UIImage imageWithData:data];
                           }];
    self.userNameLabel.text = self.message.commentUser.screenName;
    self.userNameLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.commentTimeLabel.text = self.message.commentTime;
    self.commentTimeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    self.commentContentLabel.attributedText = [[NSAttributedString alloc]
                                               initWithString:self.message.commentContent
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
