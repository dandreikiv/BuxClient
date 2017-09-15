//
//  ProductListControllerDelegate.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class Product;

@protocol ProductListControllerDelegate <NSObject>

- (void)presentDetailsForProduct:(Product *)product;

@end
