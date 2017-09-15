//
//  DataStorage.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "InMemoryDataStorage.h"
#import "Product.h"

@interface InMemoryDataStorage()

@property (nonatomic, strong) NSMutableSet <Product *> *products;

@end

@implementation InMemoryDataStorage

- (instancetype)init {
	self = [super init];
	if (self) {
		self.products = [NSMutableSet new];
	}
	return self;
}

- (NSUInteger)count {
	return self.products.count;
}

- (NSArray<Product *> *)allProducts {
	return [self.products allObjects];
}

- (void)storeProduct:(Product *)product {
	[self.products addObject:product];
}

- (void)storeProducts:(NSArray <Product *> *)products {
	[self.products addObjectsFromArray:products];
}

- (void)replaceProduct:(Product *)product withProductWithId:(NSString *)productId {
	Product *oldProduct = [self productWithId:productId];
	[self.products removeObject:oldProduct];
	[self.products addObject:product];
}

- (Product *)productWithId:(NSString *)productId {
	NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"productId = %@", productId];
	NSSet *filtered = [self.products filteredSetUsingPredicate:filterPredicate];
	return filtered.allObjects.firstObject;
}

@end
