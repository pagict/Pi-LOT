//
//  Pi_LOT_Tests.m
//  Pi-LOT Tests
//
//  Created by Peng Pagict on 4/2/14.
//  Copyright (c) 2014 pagict. All rights reserved.
//
#import "PiConnector.h"
#import <XCTest/XCTest.h>

@interface Pi_LOT_Tests : XCTestCase

@end

@implementation Pi_LOT_Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}


- (void)testConnector {
    NSURLRequest *request = [PiConnector connectURL:@"https://api.weibo.com" parameters:@{@"k1": @"1",
                                                                                          @"k2": @"2",
                                                                                          @"k3": @"3"}];
    NSLog(@"%@",request);
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
