//
//  WebSocketStatusViewModel.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketStatusViewModel.h"
#import <UIKit/UIColor.h>

@interface WebSocketStatusViewModel ()

@property (nonatomic, copy) NSString *statusString;
@property (nonatomic, strong) UIColor *statusColor;

@end

@implementation WebSocketStatusViewModel

- (instancetype)initWithStatus:(WebsocketStatus)status {
	self = [super init];
	if (self) {
		NSString *connected    = NSLocalizedString(@"Socket Connected", nil);
		NSString *disconnected = NSLocalizedString(@"Socket Disconnected", nil);
		
		self.statusString = (status == WebsocketStatusConnected) ? connected : disconnected;
		
		UIColor *connectedColor = [UIColor colorWithRed:87.0/255.0f
												  green:201.0/255.0f
												   blue:90.0f/255.0f
												  alpha:1.0f];
		
		UIColor *disConnectedColor = [UIColor colorWithRed:244.0/255.0f
														 green:113.0/255.0f
														  blue:57.0f/255.0f
														 alpha:1.0f];
		self.statusColor = (status == WebsocketStatusConnected) ? connectedColor : disConnectedColor;
	}
	return self;
}

@end
