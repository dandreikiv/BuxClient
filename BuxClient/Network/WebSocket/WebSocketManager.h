//
//  WebSocketManager.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebsocketStatus.h"

@class Product;

@protocol WebSocketManagerDelegate;
@protocol RequestBuilderProtocol;

@interface WebSocketManager : NSObject

@property (nonatomic, weak, nullable) id <WebSocketManagerDelegate> delegate;
@property (nonatomic, assign, readonly) WebsocketStatus webSocketStatus;

- (nullable instancetype)initWithRequestBuilder:(nonnull id <RequestBuilderProtocol>)requestBuilder;

- (void)openSocket;
- (void)closeSocket;

- (void)subscribeToProuduct:(nonnull Product *)product;
- (void)unsubscribeFromProduct:(nonnull Product *)product;

@end
