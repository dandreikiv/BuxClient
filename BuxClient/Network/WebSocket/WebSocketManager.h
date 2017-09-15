//
//  WebSocketManager.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@protocol WebSocketManagerDelegate;
@protocol RequestBuilderProtocol;

@interface WebSocketManager : NSObject

@property (nonatomic, weak) id <WebSocketManagerDelegate> delegate;

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder;

- (void)openSocket;
- (void)closeSocket;

- (void)subscribeToProuduct:(Product *)product;
- (void)unsubscribeFromProduct:(Product *)product;

@end
