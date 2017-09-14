//
//  ProductDetailsViewModel.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductDetailsViewModel.h"
#import "Product.h"
#import "Price.h"

@interface ProductDetailsViewModel()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, copy) NSString *priceChange;

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) NSNumberFormatter *percetFormatter;

@end

@implementation ProductDetailsViewModel

- (instancetype)initWithProduct:(Product *)product {
	self = [super init];
	if (self) {
		self.numberFormatter = [NSNumberFormatter new];
		self.numberFormatter.locale = [NSLocale currentLocale];
		self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
		self.numberFormatter.maximumFractionDigits = product.displayDecimals;
		self.numberFormatter.minimumFractionDigits = product.displayDecimals;
		
		self.percetFormatter = [NSNumberFormatter new];
		self.percetFormatter.locale = [NSLocale currentLocale];
		self.percetFormatter.numberStyle = NSNumberFormatterPercentStyle;
		self.percetFormatter.maximumFractionDigits = 2;
		self.percetFormatter.minimumFractionDigits = 2;
		
		[self updateWithProduct:product];
	}
	return self;
}

- (void)updateWithProduct:(Product *)product {
	self.name = product.displayName;
	self.currentPrice = [self.numberFormatter stringFromNumber:product.currentPrice.amount];
	self.priceChange = [self.percetFormatter stringFromNumber:[self priceChangeWithProduct:product]];
}

- (NSNumber *)priceChangeWithProduct:(Product *)product {
	NSDecimalNumber *currentPrice = [NSDecimalNumber decimalNumberWithDecimal:product.currentPrice.amount.decimalValue];
	NSDecimalNumber *closingPrice = [NSDecimalNumber decimalNumberWithDecimal:product.closingPrice.amount.decimalValue];
	
	NSDecimalNumber *priceChange = [currentPrice decimalNumberBySubtracting:closingPrice];
	return [priceChange decimalNumberByDividingBy:closingPrice];
}

@end
