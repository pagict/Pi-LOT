//
//  PiDynamicHeightTableViewCell.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/24/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PiMessage;
@interface PiDynamicHeightTableViewCell : UITableViewCell
@property (readonly, nonatomic) CGFloat height;

- (instancetype)initWithMessage:(PiMessage *)message;
- (void)updateCell;
- (NSInteger)linesOfLabel:(UILabel*)label;
- (CGFloat)lineHeightOfLabel:(UILabel*)label;
@end
