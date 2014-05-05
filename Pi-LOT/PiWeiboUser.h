//
//  PiWeiboUser.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiWeiboUser : NSObject <NSCoding>
@property (strong, nonatomic) NSString*     userId;
@property (strong, nonatomic) NSString*     screenName;
@property (strong, nonatomic) NSString*     location;
@property (strong, nonatomic) NSString*     userDescription;
@property (strong, nonatomic) NSURL*        profileImageURL;
@property (strong, nonatomic) NSString*     gender;
@property (nonatomic)         NSInteger     followersCount;
@property (nonatomic)         NSInteger     statusesCount;

- (id)initWithJsonDictionary:(NSDictionary*)dict;

@end
