//
//  DataCoordinatorOutput.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class ProductListViewModel;

@protocol DataCoordinatorOutput <NSObject>

- (void)updateListWithProducts:(NSArray <ProductListViewModel *> *)products;

@end
