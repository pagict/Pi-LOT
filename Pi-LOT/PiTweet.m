//
//  PiTweet.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTweet.h"
#import "NSString+Weibo.h"

@implementation PiTweet

- (id)initWithJsonDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.createTime = dict[@"created_at"];
        self.text       = dict[@"text"];
//        self.source     = dict[@"source"];
        self.isTruncated= [dict[@"truncated"] boolValue];
        self.user       = [[PiWeiboUser alloc] initWithJsonDictionary: dict[@"user"]];
        self.repostCount= [dict[@"reposts_count"] intValue];
        self.commentCount = [dict[@"comments_count"] intValue];
        NSString* sourceString = dict[@"source"];
        self.source = [sourceString source];
        self.retweetedStatus = nil;
        if (dict[@"retweeted_status"]) {
            self.retweetedStatus = [[PiTweet alloc] initWithJsonDictionary:dict[@"retweeted_status"]];
        }
    }
    return self;
}

@end
