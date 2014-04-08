//
//  PiWeibo.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModels.h"

@interface PiWeibo : NSObject
@property BOOL isAuthenticated;
@property (strong, nonatomic) NSString* code;
@property (strong, nonatomic) NSString* accessToken;

- (void)userShow:(PiWeiboUser*)user;
- (NSURLRequest*)requestForAuthorize;
- (NSDictionary*)dictionaryOfAccessToken;
- (NSArray*)updateTweets;
- (void)postTweet:(NSString*)tweetContent;
- (NSArray*)comments;
@end
