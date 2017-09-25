//
//  DataBaseStorage.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 25/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "DataBaseStorage.h"
#import "Product.h"
#import "RealmProduct.h"
#import <Realm/Realm.h>

@implementation DataBaseStorage

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self configureRealmWithDefaultCofiguration];
	}
	return self;
}

- (instancetype)initWithConfiguration:(RLMRealmConfiguration *)configuration
{
	self = [super init];
	if (self) {
		[RLMRealmConfiguration setDefaultConfiguration:configuration];
	}
	return self;
}


- (NSUInteger)count {
	return [RealmProduct allObjects].count;
}

- (void)configureRealmWithDefaultCofiguration {
	RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
	
	// Use the default directory, but replace the filename with the username
	config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
	   URLByAppendingPathComponent:@"bux"] URLByAppendingPathExtension:@"realm"];
	
	// Set this as the configuration used for the default Realm
	[RLMRealmConfiguration setDefaultConfiguration:config];
}

- (NSArray<Product *> *)allProducts {
	return @[];
}

- (Product *)productWithId:(NSString *)productId {
	return [Product new];
}

- (void)storeProduct:(Product *)product {
	RealmProduct *realmProduct = [RealmProduct new];
	realmProduct.productId = product.productId;
	realmProduct.displayName = product.displayName;
	
	RLMRealm *realm = [RLMRealm defaultRealm];
	[realm transactionWithBlock:^{
		[realm addObject:realmProduct];
	}];
}

- (void)storeProducts:(NSArray<Product *> *)products {
	
}

- (void)update:(Product *)product withId:(NSString *)productId {
	
}

- (void)removeProductWithId:(NSString *)productId {
	RealmProduct *product = [RealmProduct objectsWhere:@"productId == %@", productId].firstObject;
	
	RLMRealm *realm = [RLMRealm defaultRealm];
	[realm transactionWithBlock:^{
		[realm deleteObject:product];
	}];
}

- (void)cleanStorage {
	RLMRealm *realm = [RLMRealm defaultRealm];
	[realm transactionWithBlock:^{
		[realm deleteAllObjects];
	}];
}

@end
