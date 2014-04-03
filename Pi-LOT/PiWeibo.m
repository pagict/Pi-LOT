//
//  PiWeibo.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiWeibo.h"
#import "PiConnector.h"
#import "WeiboAPI.h"

@implementation PiWeibo
- (id)init {
    if (self = [super init]) {
        self.isAuthenticated = NO;
    }
    return self;
}

- (void)userShow:(PiWeiboUser *)user {
    if (!self.isAuthenticated) {
        NSLog(@"Not authenticated");
        return;
    }
    if (!user.userId && !user.screenName) {
        NSLog(@"No designated uid or screen_name");
        return;
    }

    if (user.userId) {
        NSMutableURLRequest *request = [[PiConnector connectURL:@"https://api.weibo.com/2/users/show.json"
                                                    parameters:@{@"uid": user.userId,
                                                                 @"access_token": self.accessToken,
                                                                 @"appkey": kAppKey}] mutableCopy];
        [request setHTTPMethod:@"GET"];

        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:nil];
        NSDictionary *retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                  error:nil];
        user = [user initWithJsonDictionary:retDict];
    }
}
@end
