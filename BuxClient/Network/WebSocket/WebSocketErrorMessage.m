//
//  WebSocketErrorMessage.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketErrorMessage.h"

static NSString *const kWebSocketError = @"WebSocketError";
static NSString *const kMessageTypeFailed = @"connect.failed";
static NSString *const kErrorMessagePath = @"body.developerMessage";

@interface WebSocketErrorMessage()

@property (nonatomic, strong) NSError *error;

@end

@implementation WebSocketErrorMessage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		NSString *errorMessage = [dictionary valueForKeyPath:kErrorMessagePath];
		
		self.error = [NSError errorWithDomain:kWebSocketError
										 code:0
									 userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
	}
	return self;
}

@end
