//
//  PiCommentTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiCommentTableViewCell.h"

#define kStandardAquaContraintVerticalSpace 8
#define kStandardAquaContraintHorizontalSpace 5
#define kStandardAquaContraintVerticalMargin 10
#define kStandardAquaContraintHorizontalMargin 10
@interface PiCommentTableViewCell ()
@property (strong, nonatomic) UIImageView *userProfileImageView;
@property (strong, nonatomic) UILabel *commentLabel;
@property (strong, nonatomic) UILabel *quotedLabel;
@property (strong, nonatomic) UILabel *commentUserLabel;
@end

@implementation PiCommentTableViewCell

- (id)init {
    if (self = [super init]) {
        self.userProfileImageView = [[UIImageView alloc] initWithFrame:
                                     CGRectMake(kStandardAquaContraintHorizontalMargin,
                                                kStandardAquaContraintVerticalMargin,
                                                40, 40)];
        [self.contentView addSubview:self.userProfileImageView];

        self.commentUserLabel = [[UILabel alloc] initWithFrame:
                                 CGRectMake(58, 10, 242, 30)];
        self.commentUserLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.commentUserLabel];

        self.commentLabel = [[UILabel alloc] initWithFrame:
                                CGRectMake(58, 49, 242, 60)];
        self.commentLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.commentLabel];

        self.quotedLabel = [[UILabel alloc] initWithFrame:
                               CGRectMake(58, 117, 242, 69)];
        self.quotedLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.quotedLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.quotedLabel];
    }
    return self;
}

- (void)setCellFromMessage:(PiMessage *)message {
    // set text and image view
    PiComment* comment = (PiComment*)message;
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:comment.commentUser.profileImageURL]
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.userProfileImageView.contentMode = UIViewContentModeScaleToFill;
                                           self.userProfileImageView.image = [UIImage imageWithData:data];
                                       }];
    self.commentLabel.text = comment.commentContent;
    self.quotedLabel.text =comment.quotedContent;
    self.commentUserLabel.text = comment.commentUser.screenName;

    // set views size
    int commentLines = [self linesOfLabel:self.commentLabel];
    self.commentLabel.numberOfLines = commentLines;
    CGFloat commentViewHeight = commentLines * [self lineHeightOfLabel:self.commentLabel];
    CGRect commentViewFrame = self.commentLabel.frame;
    commentViewFrame.size.height = commentViewHeight;
    self.commentLabel.frame = commentViewFrame;

    int quotedLines = [self linesOfLabel:self.quotedLabel];
    self.quotedLabel.numberOfLines = quotedLines;
    CGFloat quotedViewHeight = [self lineHeightOfLabel:self.quotedLabel]*quotedLines;
    CGRect quotedViewFrame = self.quotedLabel.frame;
    quotedViewFrame.origin.y = self.commentLabel.frame.origin.y + self.commentLabel.frame.size.height + kStandardAquaContraintVerticalSpace;
    quotedViewFrame.size.height = quotedViewHeight;
    self.quotedLabel.frame = quotedViewFrame;

    CGRect contentRect = self.contentView.frame;
    contentRect.size.height = self.height;
    self.contentView.frame = contentRect;


    /*CGRect rect = self.userProfileImageView.frame;
    NSLog(@"userProfileImageView {origin.x = %f, origin.y = %f\n\tsize.width = %f, size.height = %f}\n", rect.origin.x,rect.origin.y,rect.size.width, rect.size.height);
    rect = self.commentUserLabel.frame;
    NSLog(@"commentUserLabel {origin.x = %f, origin.y = %f\n\tsize.width = %f, size.height = %f}\n", rect.origin.x,rect.origin.y,rect.size.width, rect.size.height);
    rect = self.commentTextView.frame;
    NSLog(@"commentTextView {origin.x = %f, origin.y = %f\n\tsize.width = %f, size.height = %f}\n", rect.origin.x,rect.origin.y,rect.size.width, rect.size.height);
    rect = self.quotedTextView.frame;
    NSLog(@"quotedTextView {origin.x = %f, origin.y = %f\n\tsize.width = %f, size.height = %f}\n", rect.origin.x,rect.origin.y,rect.size.width, rect.size.height); */
}
/*
- (UIView*)contentView {
    CGRect rect = [super contentView].frame;
    NSLog(@"{origin.x = %f, origin.y = %f\n\tsize.width = %f, size.height = %f}\n", rect.origin.x,rect.origin.y,rect.size.width, rect.size.height);
    return [super contentView];
}
 */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (CGFloat)height {
//    CGFloat otherHeight = 209 - 66 - 104;
//    return otherHeight + self.commentTextView.frame.size.height + self.quotedTextView.frame.size.height;
    return self.quotedLabel.frame.origin.y + self.quotedLabel.frame.size.height + kStandardAquaContraintVerticalMargin;
}

@end
