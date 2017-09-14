//
//  WebSocketMessage.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebSocketMessageType.h"

@class WebSocketErrorMessage;
@class WebSocketQuoteMessage;

@interface WebSocketMessage : NSObject

@property (nonatomic, assign, readonly) WebSocketMessageType type;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

- (nullable WebSocketErrorMessage *)buildErorrMessage;
- (nullable WebSocketQuoteMessage *)buildQuoteMessage;

@end
