//
//  PiComment.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiComment.h"
#import "NSString+Weibo.h"

@implementation PiComment

- (id)initWithJsonDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.commentTime = dict[@"created_at"];
        self.commentContent = dict[@"text"];
        self.commentUser = [[PiWeiboUser alloc] initWithJsonDictionary:dict[@"user"]];
        NSString* sourceStr = dict[@"source"];
        self.commentSource = [sourceStr source];

        NSDictionary* quotedDictionary = dict[@"reply_comment"];
        if (!quotedDictionary) {
            quotedDictionary = dict[@"status"];
        }
        self.quotedTime = quotedDictionary[@"created_at"];
        self.quotedContent = quotedDictionary[@"text"];
        self.quotedUser = [[PiWeiboUser alloc] initWithJsonDictionary:quotedDictionary[@"user"]];
        self.quotedSource = [quotedDictionary[@"source"] source];
    }
    return self;
}

                              
@end
