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
@property (strong, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UITextView *quotedTextView;
@property (strong, nonatomic) IBOutlet UILabel *commentUserLabel;
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
        [self.contentView addSubview:self.commentTextView];

        self.quotedTextView = [[UITextView alloc] initWithFrame:
                               CGRectMake(58, 117, 242, 69)];
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
    self.commentTextView.text = comment.commentContent;
    self.quotedTextView.text =comment.quotedContent;
    self.commentUserLabel.text = comment.commentUser.screenName;

    // set views size
    CGFloat commentViewHeight = [self heightOfView:self.commentTextView];
    CGRect commentViewFrame = self.commentTextView.frame;
    commentViewFrame.size.height = commentViewHeight;
    self.commentTextView.frame = commentViewFrame;

    CGFloat quotedViewHeight = [self heightOfView:self.quotedTextView];
    CGRect quotedViewFrame = self.quotedTextView.frame;
    quotedViewFrame.origin.y = self.commentTextView.frame.origin.y + self.commentTextView.frame.size.height + kStandardAquaContraintVerticalSpace;
    quotedViewFrame.size.height = quotedViewHeight;
    self.quotedTextView.frame = quotedViewFrame;
}

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
//    CGFloat otherHeight = 209 - 66 - 104;
//    return otherHeight + self.commentTextView.frame.size.height + self.quotedTextView.frame.size.height;
    return self.quotedTextView.frame.origin.y + self.quotedTextView.frame.size.height + kStandardAquaContraintVerticalMargin;
}

@end
