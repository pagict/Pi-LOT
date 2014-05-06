//
//  PiWeibo.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModels.h"

#define NOTIFICATION_TWEETS_UPDATED     @"NOTIFICATION_TWEETS_UPDATED"
#define NOTIFICATION_COMMENTS_UPDATED   @"NOTIFICATION_COMMENTS_UPDATED"


@interface PiWeibo : NSObject
@property BOOL isAuthenticated;
@property (strong, nonatomic) NSString* code;
@property (strong, nonatomic) NSString* accessToken;

- (void)userShow:(PiWeiboUser*)user;
- (NSDictionary*)dictionaryOfAccessToken;
- (void)updateTweets;
- (void)postTweet:(NSString*)tweetContent;
- (void)comments;
@end
