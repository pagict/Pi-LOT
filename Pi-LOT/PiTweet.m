//
//  PiTweet.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/3/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiTweet.h"
#import "NSString+Weibo.h"

@interface PiTweet ()
@property (strong,nonatomic) NSMutableArray* pictureURLArray;
@end

@implementation PiTweet

- (id)initWithJsonDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.messageId  = [dict[@"id"] longLongValue];
        self.createTime = dict[@"created_at"];
        self.text       = dict[@"text"];
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

        self.pictureURLArray = nil;
        NSArray* URLStringArray = dict[@"pic_urls"];
        if (URLStringArray.count) {
            self.pictureURLArray = [[NSMutableArray alloc] initWithCapacity:URLStringArray.count];
            for (NSDictionary* urlDic in URLStringArray) {
                [self.pictureURLArray addObject:[NSURL URLWithString:urlDic[@"thumbnail_pic"]]];
            }

        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeInt:self.repostCount forKey:@"repostCount"];
    [aCoder encodeInt:self.commentCount forKey:@"commentCount"];

    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.retweetedStatus forKey:@"retweetedStatus"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.repostCount = [aDecoder decodeIntForKey:@"repostCount"];
        self.commentCount = [aDecoder decodeIntForKey:@"commentCount"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.retweetedStatus = [aDecoder decodeObjectForKey:@"retweetedStatus"];
    }
    return self;
}


@end
