//
//  PiDynamicHeightTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/24/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiDynamicHeightTableViewCell.h"

@implementation PiDynamicHeightTableViewCell
- (NSInteger)linesOfLabel:(UILabel*)label {
    NSDictionary* attribute = [label.attributedText attributesAtIndex:0
                                                       effectiveRange:NULL];
    CGSize textSize = [label.text sizeWithAttributes:attribute];
    CGRect frame = label.frame;
    int lines = textSize.width / frame.size.width + 1;
    return lines;
}

- (CGFloat)lineHeightOfLabel:(UILabel*)label {
    NSDictionary* attribute = [label.attributedText attributesAtIndex:0
                                                       effectiveRange:NULL];
    CGSize textSize = [label.text sizeWithAttributes:attribute];
    return textSize.height;
}
@end
