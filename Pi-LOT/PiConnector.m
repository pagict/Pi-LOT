//
//  PiConnector.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiConnector.h"
#import "NSString+Weibo.h"

@implementation PiConnector
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
