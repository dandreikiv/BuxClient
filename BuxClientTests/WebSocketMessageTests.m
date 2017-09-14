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

@property (nonatomic, strong) WebSocketMessage *messageWithConnectionFailedJSON;
@property (nonatomic, strong) WebSocketMessage *messageWithTradingQouteJSON;

@end

@implementation WebSocketMessageTests

- (void)setUp {
    [super setUp];
	
	NSString *connectionFailedJSONPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"ConnectionFailedMessage" ofType:@"json"];
	NSData *connectionFailedData = [NSData dataWithContentsOfFile:connectionFailedJSONPath];
	NSDictionary *connectionFailedDictionary = [self messageDictionaryFromData:connectionFailedData];
	self.messageWithConnectionFailedJSON = [[WebSocketMessage alloc] initWithDictionary:connectionFailedDictionary];
	
	
	NSString *tradingQuoteMessageJSONPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"TradingQouteMessage" ofType:@"json"];
	NSData *tradionqQoteData = [NSData dataWithContentsOfFile:tradingQuoteMessageJSONPath];
	NSDictionary *tradingQouteDictionary = [self messageDictionaryFromData:tradionqQoteData];
	self.messageWithTradingQouteJSON = [[WebSocketMessage alloc] initWithDictionary:tradingQouteDictionary];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWebSocketMessageHasConnectionFailedType {
	XCTAssertTrue(self.messageWithConnectionFailedJSON.type == WebSocketMessageTypeFailed);
}

- (void)testWebSocketErrorMessageHasProperErrorMessage {
	NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"ConnectionFailedMessage" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	NSDictionary *messageDictionary = [self messageDictionaryFromData:data];
	WebSocketErrorMessage *message = [[WebSocketErrorMessage alloc] initWithDictionary:messageDictionary];
	XCTAssertNotNil(message.error);
	XCTAssertNotNil(message.error.localizedDescription);
	
	NSString *errorMessage = [messageDictionary valueForKeyPath:@"body.developerMessage"];
	XCTAssertTrue([message.error.localizedDescription isEqualToString:errorMessage]);
}

- (void)testWebSocketMessageReturnsMessageFailedInstance {
	WebSocketErrorMessage *errorMessage = [self.messageWithConnectionFailedJSON buildErorrMessage];
	WebSocketQuoteMessage *quoteMessage = [self.messageWithConnectionFailedJSON buildQuoteMessage];
	
	XCTAssertTrue([errorMessage isKindOfClass:[WebSocketErrorMessage class]]);
	XCTAssertNil(quoteMessage);
}

- (void)testWebSocketMessageHasTradingQouteType {
	XCTAssertTrue(self.messageWithTradingQouteJSON.type == WebSocketMessageTypeQuote);
}

- (void)testWebSocketMessageReturnsMessagQouteInstance {
	WebSocketErrorMessage *errorMessage = [self.messageWithTradingQouteJSON buildErorrMessage];
	WebSocketQuoteMessage *quoteMessage = [self.messageWithTradingQouteJSON buildQuoteMessage];
	
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
