//
//  WebSocketStatusViewModel.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebsocketStatus.h"

@class UIColor;

@interface WebSocketStatusViewModel : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *statusString;
@property (nonatomic, strong, readonly, nonnull) UIColor *statusColor;

- (nullable instancetype)initWithStatus:(WebsocketStatus)status;

@end
