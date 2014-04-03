//
//  PiAppDelegate.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboAPI.h"

@interface PiAppDelegate : UIResponder <UIApplicationDelegate> 
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PiWeibo *weibo;
@end

