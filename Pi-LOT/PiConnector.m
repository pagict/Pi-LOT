//
//  PiConnector.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "PiConnector.h"

@implementation PiConnector
+ (NSURLRequest*)connectURL:(NSString *)urlString parameters:(NSDictionary *)dict {
    NSURLRequest* request;
    NSMutableString* newUrlString = [urlString mutableCopy];

    if (![[newUrlString substringFromIndex:newUrlString.length-1] compare:@"/"]) {
        [newUrlString deleteCharactersInRange: NSMakeRange(newUrlString.length-1, 1)];
    }
    [newUrlString appendString:@"?"];

    NSArray *allKey = [dict allKeys];
    for (NSString* key in allKey) {
        NSString *p = [NSString stringWithFormat:@"%@=%@&", key, [dict objectForKey:key]];
        [newUrlString appendString:p];
    }
    // delete the last '&' character
    [newUrlString deleteCharactersInRange:NSMakeRange(newUrlString.length-1, 1)];

    request = [NSURLRequest requestWithURL:[NSURL URLWithString:newUrlString]];
    return request;
}
@end
