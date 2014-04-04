//
//  PiTweet.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTweet.h"

@implementation PiTweet

- (id)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.createTime = dict[@"created_at"];
        self.text       = dict[@"text"];
//        self.source     = dict[@"source"];
        self.isTruncated= [dict[@"truncated"] boolValue];
        self.user       = [[PiWeiboUser alloc] initWithJsonDictionary: dict[@"user"]];
        self.retweetedStatus = dict[@"retweeted_status"];
        self.repostCount= [dict[@"reposts_count"] intValue];
        self.commentCount = [dict[@"comments_count"] intValue];

        NSString* sourceString = dict[@"source"];
        NSRange startRange = [sourceString rangeOfString:@">"];
        NSRange endRange = [sourceString rangeOfString:@"<"
                                               options: NSBackwardsSearch];

        self.source = [sourceString substringWithRange:NSMakeRange(startRange.location+1, endRange.location - startRange.location-1)];
    }
    return self;
}

@end
