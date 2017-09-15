//
//  DataStorageProtocol.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class Product;

@protocol DataStorageProtocol <NSObject>

@property (nonatomic, assign, readonly) NSUInteger count;

- (void)storeProduct:(Product *)product;
- (void)storeProducts:(NSArray <Product *> *)products;
- (void)update:(Product *)product withId:(NSString *)productId;

- (Product *)productWithId:(NSString *)productId;
- (NSArray <Product *> *)allProducts;

@end
