//
//  ConnectionConfiguration.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ConnectionConfiguration.h"

static NSString *const kBaseURL = @"BaseURL";
static NSString *const kWebSocketURL = @"WebSocketURL";
static NSString *const kAuthorizationToken = @"AuthorizationToken";

@interface ConnectionConfiguration()

@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSURL *webSocketURL;
@property (nonatomic, copy) NSString *authorizationToken;

@end

@implementation ConnectionConfiguration

- (instancetype)init {
	self = [super init];
	if (self) {
		NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Configuration" ofType:@"plist"];
		NSDictionary *conf = [NSDictionary dictionaryWithContentsOfFile:path];
		
		self.baseURL = [NSURL URLWithString:conf[kBaseURL]];
		self.webSocketURL = [NSURL URLWithString:conf[kWebSocketURL]];
		self.authorizationToken = conf[kAuthorizationToken];
	}
	return self;
}

@end
