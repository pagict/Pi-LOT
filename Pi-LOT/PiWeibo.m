//
//  PiWeibo.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiWeibo.h"
#import "PiConnector.h"
#import "WeiboModels.h"

#define kAppKey @"2986209980"
#define kAppSecret @"20efe02cd1e9e61ebb0ab2bc47cb4953"
#define kRedirectURL @"https://api.weibo.com/oauth2/default.html"

#define updateCount 30

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
        NSMutableURLRequest *request = [[PiConnector connectionURL:@"https://api.weibo.com/2/users/show.json"
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

- (NSURLRequest*)requestForAuthorize {
    NSString *urlString = @"https://api.weibo.com/oauth2/authorize";
    NSURLRequest *request = [PiConnector connectionURL:urlString
                                         parameters:@{@"client_id": kAppKey,
                                                      @"reponse_type": @"code",
                                                      @"redirect_uri": kRedirectURL,
                                                      @"display": @"mobile"}];
    return request;
}

- (NSDictionary*)dictionaryOfAccessToken {
    NSMutableURLRequest *request = [[PiConnector connectionURL:@"https://api.weibo.com/oauth2/access_token"
                                                 parameters:@{@"client_id": kAppKey,
                                                              @"client_secret": kAppSecret,
                                                              @"grant_type": @"authorization_code",
                                                              @"code": self.code,
                                                              @"redirect_uri": kRedirectURL}] mutableCopy];
    [request setHTTPMethod:@"POST"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    NSDictionary *retDict = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];

    return retDict;
}

- (NSArray*)updateTweets {
    __block NSMutableArray* modelTweets = [[NSMutableArray alloc] initWithCapacity:updateCount];

    NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSURLRequest *request = [PiConnector connectionURL:urlString
                                            parameters:@{@"access_token": self.accessToken}];
   /* [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:nil];
                               NSArray* tweets = retDict[@"statuses"];
                               for (NSDictionary* tweet in tweets) {
                                   PiTweet* piTweet = [[PiTweet alloc] initWithDictionary:tweet];
                                   [modelTweets addObject:piTweet];
                               }

                           }]; */
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    NSArray* tweets = retDict[@"statuses"];
    for (NSDictionary* tweet in tweets) {
//        PiTweet* piTweet = ;
        [modelTweets insertObject:[[PiTweet alloc] initWithDictionary:tweet] atIndex:modelTweets.count] ;
    }

    return modelTweets;
}

@end
