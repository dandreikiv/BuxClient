//
//  WebSocketManager.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketManager.h"
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
	}
	return self;
}

#pragma mark - SRWebSocketDelegate -

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
	
}

@end
