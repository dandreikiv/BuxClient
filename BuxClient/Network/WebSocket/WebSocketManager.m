//
//  WebSocketManager.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketManager.h"
#import "WebSocketDelegate.h"
#import "WebSocketMessage.h"
#import "WebSocketErrorMessage.h"
#import "WebSocketQuoteMessage.h"
#import "RequestBuilderProtocol.h"
#import "SRWebSocket.h"

@interface WebSocketManager() <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *socket;

@end

@implementation WebSocketManager

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder {
	self = [super init];
	if (self) {
		self.socket = [[SRWebSocket alloc] initWithURLRequest:requestBuilder.webSocketRequest];
		self.socket.delegate = self;
		
		[self.socket open];
	}
	return self;
}

#pragma mark - SRWebSocketDelegate -

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
	NSDictionary *messageDictionary = [self messageDictionaryFromString:message];
	WebSocketMessage *parsedMessage = [[WebSocketMessage alloc] initWithDictionary:messageDictionary];
	
	switch (parsedMessage.type) {
		case WebSocketMessageTypeQuote:
		{
			WebSocketQuoteMessage *quoteMessage = [parsedMessage buildQuoteMessage];
			[self updateCurrentPrice:quoteMessage.currentPrice
					forProductWithId:quoteMessage.productId];
			break;
		}
			
		case WebSocketMessageTypeFailed:
		{
			WebSocketErrorMessage *errorMessage = [parsedMessage buildErorrMessage];
			[self delegateConnectionFailureWithError:errorMessage.error];
			break;
		}
			
		case WebSocketMessageTypeConnected:
			[self delegateConnectedSuccesfully];
			break;
			
		default:
			break;
	}
}

- (void)dealloc {
	[self.socket close];
}

#pragma mark - Private -

- (NSDictionary *)messageDictionaryFromString:(NSString *)message {
	NSData *messageData = [message dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *messageDicitonary = [NSJSONSerialization JSONObjectWithData:messageData
																	  options:NSJSONReadingMutableContainers
																		error:nil];
	
	return messageDicitonary;
}

- (void)updateCurrentPrice:(NSNumber *)currentPrice forProductWithId:(NSString *)productId {
	if ([self.delegate respondsToSelector:@selector(didGetQuoteAmount:forProductWithId:)]) {
		[self.delegate didGetQuoteAmount:currentPrice forProductWithId:productId];
	}
}

- (void)delegateConnectionFailureWithError:(NSError *)error {
	if ([self.delegate respondsToSelector:@selector(didFailedToConnectWithError:)]) {
		[self.delegate didFailedToConnectWithError:error];
	}
}

- (void)delegateConnectedSuccesfully {
	if ([self.delegate respondsToSelector:@selector(didConnect)]) {
		[self.delegate didConnect];
	}
}

@end
