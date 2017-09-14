//
//  WebSocketMessageType.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

typedef NS_ENUM (NSUInteger, WebSocketMessageType) {
	WebSocketMessageTypeUndefined,
	WebSocketMessageTypeConnected,
	WebSocketMessageTypeFailed,
	WebSocketMessageTypeQuote
};
