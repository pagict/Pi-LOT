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

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.commentTime forKey:@"commentTime"];
    [aCoder encodeObject:self.commentSource forKey:@"commentSource"];
    [aCoder encodeObject:self.commentContent forKey:@"commentContent"];
    [aCoder encodeObject:self.commentUser forKey:@"commentUser"];
    [aCoder encodeObject:self.quotedTime forKey:@"quotedTime"];
    [aCoder encodeObject:self.quotedSource forKey:@"quotedSource"];
    [aCoder encodeObject:self.quotedContent forKey:@"quotedContent"];
    [aCoder encodeObject:self.quotedUser forKey:@"quotedUser"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.commentTime = [aDecoder decodeObjectForKey:@"commentTime"];
        self.commentSource = [aDecoder decodeObjectForKey:@"commentSource"];
        self.commentContent = [aDecoder decodeObjectForKey:@"commentContent"];
        self.commentUser = [aDecoder decodeObjectForKey:@"commentUser"];
        self.quotedTime = [aDecoder decodeObjectForKey:@"quoteTime"];
        self.quotedSource = [aDecoder decodeObjectForKey:@"quotedSource"];
        self.quotedContent = [aDecoder decodeObjectForKey:@"quotedContent"];
        self.quotedUser = [aDecoder decodeObjectForKey:@"quotedUser"];
    }
    return self;
}
                              
@end
