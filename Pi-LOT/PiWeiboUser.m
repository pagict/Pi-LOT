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

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.screenName forKey:@"screenName"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeObject:self.userDescription forKey:@"userDescription"];
    [aCoder encodeObject:self.profileImageURL.path forKey:@"profileImageURL"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeInteger:self.followersCount forKey:@"followersCount"];
    [aCoder encodeInteger:self.statusesCount forKey:@"statusesCount"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [ super init]) {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.screenName = [aDecoder decodeObjectForKey:@"screenName"];
        self.location = [aDecoder decodeObjectForKey:@"location"];
        self.userDescription = [aDecoder decodeObjectForKey:@"userDescription"];
        self.profileImageURL = [NSURL URLWithString:(NSString*)[aDecoder decodeObjectForKey:@"profileImageURL"]];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.followersCount = [aDecoder decodeIntegerForKey:@"followersCount"];
        self.statusesCount = [aDecoder decodeIntegerForKey:@"statusesCount"];
    }
    return self;
}


@end
