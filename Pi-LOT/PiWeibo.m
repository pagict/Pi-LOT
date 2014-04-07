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
#import "Pi-LotApp.h"


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

- (void)postTweet:(NSString*)tweetContent {
    if (tweetContent.length <= 140) {
        NSString* encodedString = [self urlencode:tweetContent];
        NSMutableURLRequest *request = [[PiConnector connectionURL:@"https://api.weibo.com/2/statuses/update.json"
                                                parameters:@{@"access_token": self.accessToken,
                                                             @"status": encodedString}] mutableCopy];

        request.HTTPMethod = @"POST";
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:NSJSONReadingAllowFragments
                                                                                             error:nil];
                               }];
//        NSData* data = [NSURLConnection sendSynchronousRequest:request
//                                             returningResponse:nil
//                                                         error:nil];
//        NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
//                                                                options:NSJSONReadingAllowFragments
//                                                                  error:nil];
    }
}


- (NSString *)urlencode:(NSString*)input{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[input UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end
