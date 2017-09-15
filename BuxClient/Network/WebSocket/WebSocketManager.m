//
//  WebSocketManager.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketManager.h"
#import "WebSocketManagerDelegate.h"
#import "WebSocketMessage.h"
#import "WebSocketErrorMessage.h"
#import "WebSocketQuoteMessage.h"
#import "RequestBuilderProtocol.h"
#import "SRWebSocket.h"
#import "Product.h"

@interface WebSocketManager() <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *socket;
@property (nonatomic, assign) WebsocketStatus webSocketStatus;
@property (nonatomic, strong) id <RequestBuilderProtocol> requestBuilder;

@end

@implementation WebSocketManager

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder {
	self = [super init];
	if (self) {
		self.requestBuilder = requestBuilder;
		[self connectWebSocket];
	}
	return self;
}

- (void)connectWebSocket {
	self.webSocketStatus = WebsocketStatusDisconnected;
	self.socket.delegate = nil;
	self.socket = nil;
	
	SRWebSocket *webSocket = [[SRWebSocket alloc] initWithURLRequest:self.requestBuilder.webSocketRequest];
	webSocket.delegate = self;
	[webSocket open];
}

- (void)openSocket {
	[self connectWebSocket];
}

- (void)closeSocket {
	self.socket.delegate = nil;
	[self.socket close];
	self.webSocketStatus = WebsocketStatusDisconnected;
}

- (void)setWebSocketStatus:(WebsocketStatus)webSocketStatus {
	if (_webSocketStatus != webSocketStatus) {
		_webSocketStatus = webSocketStatus;
		if ([self.delegate respondsToSelector:@selector(webSocketStatusDidChange:)]) {
			[self.delegate webSocketStatusDidChange:webSocketStatus];
		}
	}
}

#pragma mark - SRWebSocketDelegate -

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
	NSLog(@"message:%@", message);
	
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
			self.webSocketStatus = WebsocketStatusConnected;
			[self delegateConnectedSuccesfully];
			break;
			
		default:
			break;
	}
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
	self.socket = webSocket;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
	[self closeSocket];
}

- (void)subscribeToProuduct:(Product *)product {
	[self sendData:[self subscribeDataWithProduct:product]];
}

- (void)unsubscribeFromProduct:(Product *)product {
	[self sendData:[self unsubscribeDataWithProduct:product]];
}

- (void)sendData:(NSData *)data {
	if (self.webSocketStatus == WebsocketStatusConnected) {
		[self.socket send:data];
	}
}

- (NSData *)subscribeDataWithProduct:(Product *)product {
	NSDictionary *json = @{@"subscribeTo" : @[ [self tradingProductStringWithProduct:product] ]};
	NSData *messageData = [NSJSONSerialization dataWithJSONObject:json
														  options:NSJSONWritingPrettyPrinted
															error:NULL];
	return messageData;
}

- (NSData *)unsubscribeDataWithProduct:(Product *)product {
	NSDictionary *json = @{@"unsubscribeFrom" : @[ [self tradingProductStringWithProduct:product] ]};
	NSData *messageData = [NSJSONSerialization dataWithJSONObject:json
														  options:NSJSONWritingPrettyPrinted
															error:NULL];
	return messageData;
}

- (NSString *)tradingProductStringWithProduct:(Product *)product {
	return [NSString stringWithFormat:@"trading.product.%@", product.productId];
}

- (void)dealloc {
	[self closeSocket];
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
