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
@property (strong, nonatomic) UITextView *commentTextView;
@property (strong, nonatomic) UITextView *quotedTextView;
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
        [self.contentView addSubview:self.commentUserLabel];

        self.commentTextView = [[UITextView alloc] initWithFrame:
                                CGRectMake(58, 49, 242, 60)];
        self.commentTextView.editable = NO;
        [self.contentView addSubview:self.commentTextView];

        self.quotedTextView = [[UITextView alloc] initWithFrame:
                               CGRectMake(58, 117, 242, 69)];
        self.quotedTextView.backgroundColor = [UIColor grayColor];
        self.quotedTextView.editable = NO;
        [self.contentView addSubview:self.quotedTextView];
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
    CGRect quotedViewFrame = self.quotedTextView.frame;
    quotedViewFrame.origin.y = self.commentTextView.frame.origin.y + self.commentTextView.frame.size.height + kStandardAquaContraintVerticalSpace;
    quotedViewFrame.size.height = quotedViewHeight;
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
    return lineCount * textSize.height + 20;
}

- (CGFloat)height {
//    CGFloat otherHeight = 209 - 66 - 104;
//    return otherHeight + self.commentTextView.frame.size.height + self.quotedTextView.frame.size.height;
    return self.quotedTextView.frame.origin.y + self.quotedTextView.frame.size.height + kStandardAquaContraintVerticalMargin;
}

@end
