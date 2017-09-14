//
//  WebSocketQuoteMessage.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebSocketQuoteMessage.h"

static NSString *const kTradingQuotePath = @"body.currentPrice";
static NSString *const kTradingProductIdPath = @"body.securityId";

@interface WebSocketQuoteMessage()

@property (nonatomic, strong) NSNumber *currentPrice;
@property (nonatomic, copy  ) NSString *productId;

@end

@implementation WebSocketQuoteMessage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		self.productId = [dictionary valueForKeyPath:kTradingProductIdPath];
		
		NSString *priceString = [dictionary valueForKeyPath:kTradingQuotePath];
		self.currentPrice = @([priceString doubleValue]);
	}
	return self;
}

@end
