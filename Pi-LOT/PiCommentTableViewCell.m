//
//  PiCommentTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiCommentTableViewCell.h"

#define kStandardAquaContraintVerticalSpace 8
#define kStandardAquaContraintHorizontalSpace 8
#define kStandardAquaContraintVerticalMargin 10
#define kStandardAquaContraintHorizontalMargin 10
@interface PiCommentTableViewCell ()
@property (strong, nonatomic) UIImageView *userProfileImageView;
@property (strong, nonatomic) UITextView *commentTextView;
@property (strong, nonatomic) UITextView *quotedTextView;
@property (strong, nonatomic) UILabel *commentUserLabel;
@end

@implementation PiCommentTableViewCell

- (id)init {
    if (self = [super init]) {
        CGRect imageFrame = CGRectMake(10, 10, 40, 40);
        _userProfileImageView = [[UIImageView alloc] initWithFrame:imageFrame];
        [self.contentView addSubview:_userProfileImageView];

        CGFloat x = imageFrame.origin.x + imageFrame.size.width + kStandardAquaContraintHorizontalSpace;
        CGFloat width = self.contentView.frame.size.width - x - kStandardAquaContraintHorizontalMargin;
        CGRect commentUserFrame = CGRectMake(x,
                                  kStandardAquaContraintVerticalMargin,
                                  width,
                                  30);
        _commentUserLabel = [[UILabel alloc] initWithFrame:commentUserFrame];
        [self.contentView addSubview:_commentUserLabel];

        x = commentUserFrame.origin.x;
        CGFloat y = commentUserFrame.origin.y + kStandardAquaContraintVerticalSpace + commentUserFrame.size.height;
        CGRect commentFrame = CGRectMake(x, y, width, 5);
        _commentTextView = [[UITextView alloc] initWithFrame:commentFrame];
        [self.contentView addSubview:_commentTextView];

        y = y + commentFrame.size.height + kStandardAquaContraintVerticalSpace;
        CGRect quotedFrame = CGRectMake(x, y, width, 5);
        _quotedTextView = [[UITextView alloc] initWithFrame:quotedFrame];
        [self.contentView addSubview:_quotedTextView];
    }
    return self;
}

- (void)setCellFrom:(PiMessage *)message {
    // set text and image view
    PiComment* comment = (PiComment*)message;
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:comment.commentUser.profileImageURL]
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.userProfileImageView.contentMode = UIViewContentModeScaleToFill;
                                           self.userProfileImageView.image = [UIImage imageWithData:data];
                                       }];
    self.commentUserLabel.text = comment.commentUser.screenName;
    self.commentTextView.text = comment.commentContent;
    self.quotedTextView.text =comment.quotedContent;

    // set views size
    CGFloat commentViewHeight = [self heightOfView:self.commentTextView];
    CGFloat x = self.commentUserLabel.frame.origin.x;
    CGFloat y = self.commentUserLabel.frame.origin.y + self.commentUserLabel.frame.size.height + kStandardAquaContraintVerticalSpace;
    CGFloat width = self.commentUserLabel.frame.size.width;
    CGRect commentViewFrame = CGRectMake(x, y, width, commentViewHeight);
    self.commentTextView.frame = commentViewFrame;

    CGFloat quotedViewHeight = [self heightOfView:self.quotedTextView];
    CGFloat qx = self.commentTextView.frame.origin.x;
    CGFloat qy = self.commentTextView.frame.origin.y + self.commentTextView.frame.size.height + kStandardAquaContraintVerticalSpace;
    CGFloat qwidth = self.commentTextView.frame.size.width;
    CGRect quotedViewFrame = CGRectMake(qx, qy, qwidth, quotedViewHeight);
    self.quotedTextView.frame = quotedViewFrame;

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

- (CGFloat)heightOfView:(UIView*)view {
    UITextView* textView = (UITextView*)view;
    NSDictionary* attri = [textView.attributedText attributesAtIndex:0
                                                      effectiveRange:nil];
    CGSize textSize = [textView.text sizeWithAttributes:attri];
    int lineCount = textSize.width / textView.frame.size.width + 1;
    return lineCount * textSize.height;
}

- (CGFloat)height {
    return self.commentUserLabel.frame.size.height + self.commentTextView.frame.size.height + self.quotedTextView.frame.size.height + 2* kStandardAquaContraintVerticalSpace + 2* kStandardAquaContraintVerticalMargin;
}

@end
