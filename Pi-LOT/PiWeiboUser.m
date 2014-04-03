//
//  PiWeiboUser.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiWeiboUser.h"

@implementation PiWeiboUser

- (id)initWithJsonDictionary:(NSDictionary *)dict {
    if (self=[super init]) {
        self.userId = dict[@"id"];
        self.screenName   = dict[@"screen_name"];
        self.location = dict[@"location"];
        self.userDescription = dict[@"description"];
        self.profileImageURL = [NSURL URLWithString:dict[@"profile_image_url"]];
        self.gender = dict[@"gender"];
        self.followersCount = [dict[@"followers_count"] integerValue];
        self.statusesCount = [dict[@"statuses_count"] integerValue];
    }

    return self;
}

@end
