//
//  WebSocketManager.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebSocketDelegate;
@protocol RequestBuilderProtocol;

@interface WebSocketManager : NSObject

@property (nonatomic, weak) id <WebSocketDelegate> delegate;

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder;

@end
