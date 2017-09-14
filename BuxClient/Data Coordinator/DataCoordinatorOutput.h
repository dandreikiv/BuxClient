//
//  DataCoordinatorOutput.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class Product;

@protocol DataCoordinatorProductListOutput <NSObject>

- (void)updateListWithProducts:(NSArray <Product *> *)products;

@end

@protocol DataCoordinatorProductDetailsOutput <NSObject>

- (void)updateWithProduct:(Product *)product;

@end
