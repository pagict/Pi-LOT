//
//  PiTweet.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PiWeiboUser.h"

#define kTWEET_CHARACTER_LIMIT   140

@interface PiTweet : NSObject
@property (strong, nonatomic) NSString*     createTime;
@property (strong, nonatomic) NSString*     text;
@property (strong, nonatomic) NSString*     source;
@property BOOL                              isTruncated;
@property (strong, nonatomic) PiWeiboUser*  user;
@property (strong, nonatomic) PiTweet*      retweetedStatus;
@property int                               repostCount;
@property int                               commentCount;

- (id)initWithDictionary:(NSDictionary*)dict;
@end
