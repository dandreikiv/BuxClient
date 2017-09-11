//
//  Price.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "Price.h"

static NSString *const kAmount = @"amount";
static NSString *const kCurrency = @"currency";
static NSString *const kDecimals = @"decimals";

@interface Price()

@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, assign) NSUInteger decimals;

@end

@implementation Price

- (instancetype)initWithPriceDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		self.decimals = [dictionary[kDecimals] integerValue];
		self.currency = dictionary[kCurrency];
		self.amount = @([dictionary[kAmount] doubleValue]);
	}
	return self;
}

@end
