//
//  PiCommentTableViewCell.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModels.h"

@interface PiCommentTableViewCell : UITableViewCell
@property (readonly, nonatomic) CGFloat height;
- (void)setCellFrom:(PiMessage*)message;
@end
