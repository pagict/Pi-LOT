//
//  NSString+Weibo.m
//  Pi-LOT
//
//  Created by Peng Pagict on 4/8/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import "NSString+Weibo.h"

@implementation NSString (Weibo)
- (NSString*)source {
    NSRange start = [self rangeOfString:@">"];
    NSRange end   = [self rangeOfString:@"<"
                                options:NSBackwardsSearch];

    return [self substringWithRange:NSMakeRange(start.location+1, end.location - start.location -1)];
}

- (NSString*)formatURLString {
    NSMutableString* newUrlString = [self mutableCopy];

    if (![[newUrlString substringFromIndex:newUrlString.length-1] compare:@"/"]) {
        [newUrlString deleteCharactersInRange: NSMakeRange(newUrlString.length-1, 1)];
    }
    [newUrlString appendString:@"?"];
    return newUrlString;
}


@end
