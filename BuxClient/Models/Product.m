//
//  Product.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "Product.h"
#import "Price.h"

static NSString *const kSymbol = @"symbol";
static NSString *const kDisplayName = @"displayName";
static NSString *const kCurrentPrice = @"currentPrice";
static NSString *const kClosingPrice = @"closingPrice";
static NSString *const kProductId = @"securityId";
static NSString *const kCategory = @"category";
static NSString *const kQuoteCurrency = @"quoteCurrency";
static NSString *const kProductMarketStatus = @"productMarketStatus";
static NSString *const kMarkenOpen = @"OPEN";
static NSString *const kDisplayDecimals = @"displayDecimals";

@interface Product()

@property (nonatomic, copy) NSString *symbol;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *productDescription;
@property (nonatomic, copy) NSString *quoteCurrency;
@property (nonatomic, strong) Price *currentPrice;
@property (nonatomic, strong) Price *closingPrice;
@property (nonatomic, assign) BOOL marketOpen;
@property (nonatomic, assign) NSUInteger displayDecimals;

@end

@implementation Product

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		self.symbol = dictionary[kSymbol];
		self.displayName = dictionary[kDisplayName];
		self.productId = dictionary[kProductId];
		self.category = dictionary[kCategory];
		self.marketOpen = [kMarkenOpen isEqualToString:dictionary[kProductMarketStatus]];
		self.displayDecimals = [dictionary[kDisplayDecimals] unsignedIntegerValue];
		
		self.currentPrice = [[Price alloc] initWithPriceDictionary:dictionary[kCurrentPrice]];
		self.closingPrice = [[Price alloc] initWithPriceDictionary:dictionary[kClosingPrice]];
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@: %@: %@", self.displayName, self.productId, self.currentPrice.amount];
}

- (BOOL)isEqual:(Product *)object {
	if (self == object) {
		return YES;
	}
	
	return [self.productId isEqualToString:object.productId];
}

@end
