//
//  WebSocketStatusViewModel.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketStatusViewModel.h"

@interface WebSocketStatusViewModel ()

@property (nonatomic, copy) NSString *statusString;

@end

@implementation WebSocketStatusViewModel

- (instancetype)initWithStatus:(WebsocketStatus)status {
	self = [super init];
	if (self) {
		NSString *connected    = NSLocalizedString(@"Socket Connected", nil);
		NSString *disconnected = NSLocalizedString(@"Socket Disconnected", nil);
		
		self.statusString = (status == WebsocketStatusConnected) ? connected : disconnected;
	}
	return self;
}

@end
