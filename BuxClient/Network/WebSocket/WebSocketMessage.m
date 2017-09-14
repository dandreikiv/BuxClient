//
//  WebSocketMessage.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketMessage.h"
#import "WebSocketErrorMessage.h"
#import "WebSocketQuoteMessage.h"

static NSString *const kMessageType = @"t";
static NSString *const kMessageTypeConnected = @"connect.connected";
static NSString *const kMessageTypeFailed = @"connect.failed";
static NSString *const kMessageTypeQuote = @"trading.quote";


@interface WebSocketMessage()

@property (nonatomic, assign) WebSocketMessageType type;
@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation WebSocketMessage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		self.dictionary = dictionary;
		self.type = [self typeWithString:self.dictionary[kMessageType]];
	}
	return self;
}

- (WebSocketErrorMessage *)buildErorrMessage {
	if (self.type != WebSocketMessageTypeFailed) {
		return nil;
	}
	return [[WebSocketErrorMessage alloc] initWithDictionary:self.dictionary];
}

- (WebSocketQuoteMessage *)buildQuoteMessage {
	if (self.type != WebSocketMessageTypeQuote) {
		return nil;
	}
	return [[WebSocketQuoteMessage alloc] initWithDictionary:self.dictionary];
}

- (WebSocketMessageType)typeWithString:(NSString *)string {
	WebSocketMessageType type = WebSocketMessageTypeUndefined;
	
	if ([kMessageTypeFailed isEqualToString:string]) {
		type = WebSocketMessageTypeFailed;
	}
	else if ([kMessageTypeConnected isEqualToString:string]) {
		type = WebSocketMessageTypeConnected;
	}
	else if ([kMessageTypeQuote isEqualToString:string]) {
		type = WebSocketMessageTypeQuote;
	}
	
	return type;
}

@end
