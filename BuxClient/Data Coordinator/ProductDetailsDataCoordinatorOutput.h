//
//  ProductDetailsDataCoordinatorOutput.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class Product;

@protocol ProductDetailsDataCoordinatorOutput <NSObject>

- (void)updateWithProduct:(Product *)product;

@end
