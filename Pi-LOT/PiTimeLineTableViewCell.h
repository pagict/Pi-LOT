//
//  PiTimeLineTableViewCell.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiWeibo.h"
#import "PiDynamicHeightTableViewCell.h"

@interface PiTimeLineTableViewCell : PiDynamicHeightTableViewCell
@property (readonly) CGFloat   height;
- (void)setCellFrom:(PiMessage*)tweet;
@end
