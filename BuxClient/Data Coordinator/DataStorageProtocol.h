//
//  DataStorageProtocol.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class Product;

@protocol DataStorageProtocol <NSObject>

- (void)storeProducts:(NSArray <Product *> *)products;
- (void)replaceProduct:(Product *)product withProductWithId:(NSString *)productId;

- (Product *)findProductWithId:(NSString *)productId;

@end
