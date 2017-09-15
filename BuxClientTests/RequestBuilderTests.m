//
//  RequestBuilderTests.m
//  BuxClientTests
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RequestBuilder.h"
#import "Product.h"
#import "ConnectionConfiguration.h"

static NSString *const kProductsPath = @"core/16/products/";

@interface RequestBuilderTests : XCTestCase

@property (nonatomic, strong) RequestBuilder *requestBuilder;
@property (nonatomic, strong) ConnectionConfiguration *configuration;

@end

@implementation RequestBuilderTests

- (void)setUp {
    [super setUp];
	
	self.configuration = [ConnectionConfiguration new];
	self.requestBuilder = [[RequestBuilder alloc] initWithConfigurataion:self.configuration];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAllProductsRequestHasProperURLAndAuthToken {
	NSURL *url = [NSURL URLWithString:kProductsPath relativeToURL:self.configuration.baseURL];
	
	NSURLRequest *request = [self.requestBuilder productsRequest];
	XCTAssertTrue([request.URL.absoluteString isEqualToString:url.absoluteString]);
	XCTAssertTrue([[request valueForHTTPHeaderField:@"Authorization"] isEqualToString:self.configuration.authorizationToken]);
}

- (void)testProductDetailsRequestProperURLAndAuthToken {
	NSString *productID = @"Some_ID";
	Product *product = [[Product alloc] initWithDictionary:@{@"securityId": productID}];
	
	NSString *productDetaisQuery = [kProductsPath stringByAppendingPathComponent:productID];
	NSURL *url = [NSURL URLWithString:productDetaisQuery relativeToURL:self.configuration.baseURL];
	
	NSURLRequest *request = [self.requestBuilder productDetailsRequestWithProduct:product];
	XCTAssertTrue([request.URL.absoluteString isEqualToString:url.absoluteString]);
	XCTAssertTrue([[request valueForHTTPHeaderField:@"Authorization"] isEqualToString:self.configuration.authorizationToken]);
}

- (void)testWebSocketRequestHasProperURLAndAuthToken {
	NSURL *url = self.configuration.webSocketURL;
	
	NSURLRequest *request = [self.requestBuilder webSocketRequest];
	XCTAssertTrue([request.URL.absoluteString isEqualToString:url.absoluteString]);
	XCTAssertTrue([[request valueForHTTPHeaderField:@"Authorization"] isEqualToString:self.configuration.authorizationToken]);
}

@end
