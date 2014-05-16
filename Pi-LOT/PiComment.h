//
//  PiComment.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PiWeiboUser.h"
#import "PiMessage.h"

@interface PiComment : PiMessage
@property (strong, nonatomic) NSDate* commentTime;
@property (strong, nonatomic) NSString* commentSource;
@property (strong, nonatomic) NSString* commentContent;
@property (strong, nonatomic) PiWeiboUser* commentUser;
//
@property (strong, nonatomic) NSDate* quotedTime;
@property (strong, nonatomic) NSString* quotedSource;
@property (strong, nonatomic) NSString* quotedContent;
@property (strong, nonatomic) PiWeiboUser* quotedUser;


- (id)initWithJsonDictionary:(NSDictionary*)dict;
@end
