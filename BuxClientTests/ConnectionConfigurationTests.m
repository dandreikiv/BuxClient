//
//  BuxClientTests.m
//  BuxClientTests
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ConnectionConfiguration.h"

static NSString *const kBaseURL = @"BaseURL";
static NSString *const kWebSocketURL = @"WebSocketURL";
static NSString *const kAuthorizationToken = @"AuthorizationToken";

@interface BuxClientTests : XCTestCase

@property (nonatomic, strong) ConnectionConfiguration *conf;
@property (nonatomic, strong) NSDictionary *confDict;

@end

@implementation BuxClientTests

- (void)setUp {
    [super setUp];
	self.conf = [ConnectionConfiguration new];
	
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Configuration" ofType:@"plist"];
	self.confDict = [NSDictionary dictionaryWithContentsOfFile:path];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConfigurationPropertiesAreNotNil {
	XCTAssertNotNil(self.conf.baseURL);
	XCTAssertNotNil(self.conf.webSocketURL);
	XCTAssertNotNil(self.conf.authorizationToken);
}

- (void)testConfigurationHasProperBaseURL {
	NSString *plistString = self.confDict[kBaseURL];
	NSString *urlString = self.conf.baseURL.absoluteString;
	
	XCTAssertTrue([plistString isEqualToString:urlString]);
}

- (void)testConfigurationHasProperWebSocketURL {
	NSString *plistString = self.confDict[kWebSocketURL];
	NSString *urlString = self.conf.webSocketURL.absoluteString;
	
	XCTAssertTrue([plistString isEqualToString:urlString]);
}

- (void)testConfigurationHasProperAuthorizationToken {
	NSString *plistString = self.confDict[kAuthorizationToken];
	NSString *urlString = self.conf.authorizationToken;
	
	XCTAssertTrue([plistString isEqualToString:urlString]);
}

@end
