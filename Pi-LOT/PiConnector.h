//
//  PiConnector.h
//  Pi-LOT
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiConnector : NSObject
+ (NSURLRequest*)requestGETwithURL:(NSString *)urlString parameters:(NSDictionary *)dict;
+ (NSURLRequest*)requestPOSTwithURL:(NSString*)urlString parameters:(NSDictionary*)dict;
@end
