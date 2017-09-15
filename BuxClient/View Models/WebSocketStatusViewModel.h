//
//  WebSocketStatusViewModel.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebsocketStatus.h"

@interface WebSocketStatusViewModel : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *statusString;

- (nullable instancetype)initWithStatus:(WebsocketStatus)status;

@end
