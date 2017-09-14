//
//  ProductCellViewModel.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductCellViewModel.h"
#import "Product.h"
#import "Price.h"

@interface ProductCellViewModel()

@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation ProductCellViewModel

- (instancetype)initWithProuduct:(Product *)product {
	self = [super init];
	if (self) {
		self.numberFormatter = [NSNumberFormatter new];
		self.numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
		self.numberFormatter.currencyCode = self.product.
		
		self.product = product;
		self.productName = product.displayName;
	}
	return self;
}

@end
