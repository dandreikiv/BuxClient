//
//  ProductListViewModel.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductListViewModel.h"
#import "Product.h"

@interface ProductListViewModel()

@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *category;

@end

@implementation ProductListViewModel

- (instancetype)initWithProduct:(Product *)product {
	self = [super init];
	if (self) {
		self.displayName = [product.displayName uppercaseString];
		self.category = [product.category capitalizedString];
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@: %@", self.category, self.displayName];
}

@end
