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

@interface PiWeibo ()
@end

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
        NSMutableURLRequest *request = [[PiConnector requestGETwithURL:@"https://api.weibo.com/2/users/show.json"
                                                            parameters:@{@"uid": user.userId,
                                                                         @"access_token": self.accessToken,
                                                                         @"appkey": kAppKey}] mutableCopy];

        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:nil];
        NSDictionary *retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                  error:nil];
        user = [user initWithJsonDictionary:retDict];
    }
}



- (NSDictionary*)dictionaryOfAccessToken {
    NSMutableURLRequest *request = [[PiConnector requestPOSTwithURL:@"https://api.weibo.com/oauth2/access_token"
                                                 parameters:@{@"client_id": kAppKey,
                                                              @"client_secret": kAppSecret,
                                                              @"grant_type": @"authorization_code",
                                                              @"code": self.code,
                                                              @"redirect_uri": kRedirectURL}] mutableCopy];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    NSDictionary *retDict = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:nil];

    return retDict;
}

- (void)updateTweets {
    NSMutableArray* modelTweets = [[NSMutableArray alloc] initWithCapacity:updateCount];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if ([PiConnector isNetworkAvailable]) { // network is available, data update from net
        NSString *urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
        NSURLRequest *request = [PiConnector requestGETwithURL:urlString
                                                    parameters:@{@"access_token": self.accessToken}];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:NSJSONReadingMutableContainers
                                                                                             error:nil];
                                   NSArray* tweets = retDict[@"statuses"];
                                   for (NSDictionary* tweet in tweets) {
                                       PiTweet* piTweet = [[PiTweet alloc] initWithJsonDictionary:tweet];
                                       [modelTweets addObject:piTweet];
                                       [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:piTweet]
                                                        forKey:[NSString stringWithFormat:@"tweet%03d", modelTweets.count]];
                                   }

                                   [[NSNotificationCenter defaultCenter]
                                    postNotificationName:NOTIFICATION_TWEETS_UPDATED
                                    object:modelTweets];
                               }];
        /*
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:nil];
        NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
        NSArray* tweets = retDict[@"statuses"];
        for (NSDictionary* tweet in tweets) {
            PiTweet* piTweet = [[PiTweet alloc] initWithJsonDictionary:tweet];
            [modelTweets addObject:piTweet];

            [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:piTweet] forKey:[NSString stringWithFormat:@"tweet%03d", modelTweets.count+1]];
        } */
    } else {
        int index = 1;
        while (index++) {
            NSString* key = [NSString stringWithFormat:@"tweet%03d", index];
            if ([userDefaults objectForKey:key]) {
                PiTweet* data = (PiTweet *)[NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:key]];
                [modelTweets addObject: data];
            }
        }
        [[NSNotificationCenter defaultCenter]
         postNotificationName:NOTIFICATION_TWEETS_UPDATED
         object:modelTweets];
    }

    //  return modelTweets;
}

- (void)postTweet:(NSString*)tweetContent {
    if ([PiConnector isNetworkAvailable]) {
        if (tweetContent.length <= 140) {
            NSString* encodedString = [self urlencode:tweetContent];
            NSURLRequest* request = [PiConnector requestPOSTwithURL:@"https://api.weibo.com/2/statuses/update.json"
                                                         parameters:@{@"status": encodedString,
                                                                      @"access_token": self.accessToken}];

            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

                                       NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                               options:NSJSONReadingAllowFragments
                                                                                                 error:nil];
#pragma unused(retDict)
                                   }];
            //        NSData* data = [NSURLConnection sendSynchronousRequest:request
            //                                             returningResponse:nil
            //                                                         error:nil];
            //        NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
            //                                                                options:NSJSONReadingAllowFragments
            //                                                                  error:nil];
        }
    }
}

- (void)comments {
    NSMutableArray* commentsArray = [[NSMutableArray alloc] init];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if ([PiConnector isNetworkAvailable]) {
        NSURLRequest* request = [PiConnector requestGETwithURL:@"https://api.weibo.com/2/comments/timeline.json"
                                                    parameters:@{@"access_token" : self.accessToken}];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[[NSOperationQueue alloc] init]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:NSJSONReadingAllowFragments
                                                                                             error:nil];
                                   NSArray* metaComment = retDict[@"comments"];
                                   for (NSDictionary* commentDict in metaComment) {
                                       PiComment* comment = [[PiComment alloc] initWithJsonDictionary:commentDict];
                                       [commentsArray addObject:comment];
                                       NSData* commentData = [NSKeyedArchiver archivedDataWithRootObject:comment];
                                       [userDefaults setObject:commentData
                                                        forKey:[NSString stringWithFormat:@"comment%03d",commentsArray.count]];
                                   }
                                   [[NSNotificationCenter defaultCenter]
                                    postNotificationName:NOTIFICATION_COMMENTS_UPDATED
                                    object:commentsArray];
                               }];
        /*NSData* data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil
                                                         error:nil];
        NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                  error:nil];
        NSArray* metaComment = retDict[@"comments"];
        for (NSDictionary* commentDict in metaComment) {
            PiComment* comment = [[PiComment alloc] initWithJsonDictionary:commentDict];
            [commentsArray addObject:comment];
            NSData* commentData = [NSKeyedArchiver archivedDataWithRootObject:comment];
            [userDefaults setObject:commentData forKey:[NSString stringWithFormat:@"comment%03d", commentsArray.count]];
        }*/
    } else {
        int index = 1;
        while (index++) {
            NSString* key = [NSString stringWithFormat:@"comment%03d",index];
            if ([userDefaults objectForKey:key]) {
                PiComment* comment = (PiComment*)[NSKeyedUnarchiver unarchiveObjectWithData:
                                                  [userDefaults objectForKey:key]];
                [commentsArray addObject:comment];
            }
        }
        [[NSNotificationCenter defaultCenter]
         postNotificationName:NOTIFICATION_COMMENTS_UPDATED
         object:commentsArray];
    }
}

- (void)commentOfTweet:(PiTweet *)tweet {
    if ([PiConnector isNetworkAvailable]) {
        NSMutableArray *commentsArray = [[NSMutableArray alloc] init];
        [NSURLConnection sendAsynchronousRequest:
                                           [PiConnector requestGETwithURL:@"https://api.weibo.com/2/comments/show.json"
                                                               parameters:@{@"access_token": self.accessToken,
                                                                            @"id": [NSString stringWithFormat:@"%llu",tweet.messageId]
                                                                            }]
                                           queue:[[NSOperationQueue alloc] init]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSDictionary* retDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                           options:NSJSONReadingAllowFragments
                                                                                             error:nil];
                                   NSArray* metaArray = retDict[@"comments"];
                                   for (NSDictionary* dict in metaArray) {
                                       PiComment* c = [[PiComment alloc] initWithJsonDictionary:dict];
                                       [commentsArray addObject:c];
                                   }

                                   [[NSNotificationCenter defaultCenter]
                                    postNotificationName:NOTIFICATION_COMMENTSOFTWEET_UPDATED
                                    object:commentsArray];
                               }];
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
