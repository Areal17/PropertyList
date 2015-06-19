//
//  PropertyListTests.m
//  PropertyListTests
//
//  Created by Ingo Wiederoder on 19.06.15.
//  Copyright (c) 2015 Ingo Wiederoder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DocumentManager.h"

@interface PropertyListTests : XCTestCase

@property (nonatomic, strong) DocumentManager *dm;

@end

@implementation PropertyListTests

- (void)setUp {
    [super setUp];
    _dm = [[DocumentManager alloc] initWithPlistName:@"Colors.plist"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
         [self.dm getValuesFromPlist:@"Colors.plist"];
    }];
}

- (void)testPlistAccess {
    NSMutableDictionary *values = [self.dm getValuesFromPlist:@"Colors.plist"];
    XCTAssertNotNil(values);
}

@end
