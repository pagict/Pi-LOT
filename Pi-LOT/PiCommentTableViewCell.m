//
//  PiCommentTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiCommentTableViewCell.h"

@implementation PiCommentTableViewCell

- (void)setCellFrom:(PiMessage *)message {
    PiComment* comment = (PiComment*)message;
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:comment.commentUser.profileImageURL]
                                       queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                           self.userProfileImageView.contentMode = UIViewContentModeScaleToFill;
                                           self.userProfileImageView.image = [UIImage imageWithData:data];
                                       }];
    self.commentTextView.text = comment.commentContent;
    self.quotedTextView.text =comment.quotedContent;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
