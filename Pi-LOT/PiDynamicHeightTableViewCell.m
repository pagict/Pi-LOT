//
//  PiDynamicHeightTableViewCell.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/24/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiDynamicHeightTableViewCell.h"

@interface PiDynamicHeightTableViewCell ()
@end
@implementation PiDynamicHeightTableViewCell
- (instancetype)initWithMessage:(PiMessage *)message {
    if (self = [super init]) {
    }
    return self;
}
- (void)updateCell {
    
}
- (NSInteger)linesOfLabel:(UILabel*)label {
    CGSize textSize = [label.attributedText size];
    return textSize.width / label.frame.size.width + 1;
}

- (CGFloat)lineHeightOfLabel:(UILabel*)label {
    NSDictionary* attribute = [label.attributedText attributesAtIndex:0
                                                       effectiveRange:NULL];
    CGSize textSize = [label.text sizeWithAttributes:attribute];
    return textSize.height;
}
@end
