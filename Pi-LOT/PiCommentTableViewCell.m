//
//  PiCommentTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiCommentTableViewCell.h"

#define kStandardAquaContraintSpace 8
@interface PiCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITextView *quotedTextView;
@property (weak, nonatomic) IBOutlet UILabel *commentUserLabel;
@end

@implementation PiCommentTableViewCell

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
    quotedViewFrame.origin.y = self.commentTextView.frame.origin.y + self.commentTextView.frame.size.height + kStandardAquaContraintSpace;
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
    CGFloat otherHeight = 209 - 66 - 104;
    return otherHeight + self.commentTextView.frame.size.height + self.quotedTextView.frame.size.height;
}

@end
