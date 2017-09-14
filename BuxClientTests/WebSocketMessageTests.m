//
//  WebSocketMessageTests.m
//  BuxClientTests
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WebSocketMessage.h"
#import "WebSocketQuoteMessage.h"
#import "WebSocketErrorMessage.h"

@interface WebSocketMessageTests : XCTestCase

@end

@implementation WebSocketMessageTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWebSocketMessageHasConnectionFailedType {
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"ConnectionFailedMessage" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	NSDictionary *messageDictionary = [self messageDictionaryFromData:data];
	WebSocketMessage *message = [[WebSocketMessage alloc] initWithDictionary:messageDictionary];
	XCTAssertTrue(message.type == WebSocketMessageTypeFailed);
}

- (void)testWebSocketMessageReturnsMessageFailedInstance {
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"ConnectionFailedMessage" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	NSDictionary *messageDictionary = [self messageDictionaryFromData:data];
	WebSocketMessage *message = [[WebSocketMessage alloc] initWithDictionary:messageDictionary];
	
	WebSocketErrorMessage *errorMessage = [message buildErorrMessage];
	WebSocketQuoteMessage *quoteMessage = [message buildQuoteMessage];
	
	XCTAssertTrue([errorMessage isKindOfClass:[WebSocketErrorMessage class]]);
	XCTAssertNil(quoteMessage);
}

- (void)testWebSocketMessageHasTradingQouteType {
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"TradingQouteMessage" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	NSDictionary *messageDictionary = [self messageDictionaryFromData:data];
	WebSocketMessage *message = [[WebSocketMessage alloc] initWithDictionary:messageDictionary];
	XCTAssertTrue(message.type == WebSocketMessageTypeQuote);
}

- (void)testWebSocketMessageReturnsMessagQouteInstance {
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"TradingQouteMessage" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	NSDictionary *messageDictionary = [self messageDictionaryFromData:data];
	WebSocketMessage *message = [[WebSocketMessage alloc] initWithDictionary:messageDictionary];
	
	WebSocketErrorMessage *errorMessage = [message buildErorrMessage];
	WebSocketQuoteMessage *quoteMessage = [message buildQuoteMessage];
	
	XCTAssertTrue([quoteMessage isKindOfClass:[WebSocketQuoteMessage class]]);
	XCTAssertNil(errorMessage);
}

#pragma mark - Helpers -

- (NSDictionary *)messageDictionaryFromData:(NSData *)data {
	NSDictionary *messageDicitonary = [NSJSONSerialization JSONObjectWithData:data
																	  options:NSJSONReadingMutableContainers
																		error:nil];
	
	return messageDicitonary;
}


@end
