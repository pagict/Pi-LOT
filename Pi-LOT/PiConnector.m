//
//  PiConnector.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiConnector.h"
#import "NSString+Weibo.h"
#import "Pi-LotApp.h"
#import "Reachability.h"

@implementation PiConnector
+ (BOOL)isNetworkAvailable {
    BOOL isAvailable = NO;
    Reachability* r = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [r currentReachabilityStatus];
    if (status != NotReachable) {
        isAvailable = YES;
    }
    return isAvailable;
}

+ (NSURLRequest*)requestGETwithURL:(NSString *)urlString parameters:(NSDictionary *)dict {
    NSMutableURLRequest* request;

    NSMutableString* newUrlString = (NSMutableString*)[urlString formatURLString];
    [newUrlString appendString:[self stringFromParameterDictionary:dict]];

    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newUrlString]];
    request.HTTPMethod = @"GET";
    return request;
}

+ (NSURLRequest*)requestPOSTwithURL:(NSString*)urlString parameters:(NSDictionary*)dict {
    NSMutableString* newUrlString = (NSMutableString*)[urlString formatURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newUrlString]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[self stringFromParameterDictionary:dict] dataUsingEncoding:NSStringEncodingConversionAllowLossy];

    return request;
}

+ (NSURLRequest*)requestForAuthorize {
    NSString *urlString = @"https://api.weibo.com/oauth2/authorize";
    NSURLRequest *request = [PiConnector requestGETwithURL:urlString
                                                parameters:@{@"client_id": kAppKey,
                                                             @"reponse_type": @"code",
                                                             @"redirect_uri": kRedirectURL,
                                                             @"display": @"mobile"}];
    return request;
}



+ (NSString*)stringFromParameterDictionary:(NSDictionary*)dict {
    NSMutableString* paramterString = [NSMutableString string];
    NSArray *allKey = [dict allKeys];
    for (NSString* key in allKey) {
        NSString *p = [NSString stringWithFormat:@"%@=%@&", key, [dict objectForKey:key]];
        [paramterString appendString:p];
    }
    // delete last '&' character
    [paramterString deleteCharactersInRange:NSMakeRange(paramterString.length-1, 1)];
    return paramterString;
}
@end
