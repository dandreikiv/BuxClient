//
//  DataStorageProtocol.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class Product;

@protocol DataStorageProtocol <NSObject>

/**
 Returns total number of products in data storage.
 */
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 Stores given product to data storage.

 @param product a product to store.
 */
- (void)storeProduct:(nonnull Product *)product;


/**
 Stores a list of prouducts to data storage.

 @param products a list of products.
 */
- (void)storeProducts:(nonnull NSArray <Product *> *)products;


/**
 Updates product in data storage which identifier is equal to given productId with info
 from given product.

 @param product product which has new data.
 @param productId identifier of a product which should be updated.
 */
- (void)update:(nonnull Product *)product
		withId:(nonnull NSString *)productId;


/**
 Returns a product with given prouductId.

 @param productId identifier of a product to return.
 @return Product or nil, in case product with given id was not fouund.
 */
- (nullable Product *)productWithId:(nonnull NSString *)productId;


/**
 Returns list of all stored products in datastorage.

 @return a list of products.
 */
- (nullable NSArray <Product *> *)allProducts;

@end
