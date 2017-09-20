//
//  ProductDetailsViewController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsCoordinatorOutput.h"

@class Product;
@class ProductDetailsCoordinator;

@interface ProductDetailsViewController : UIViewController <ProductDetailsCoordinatorOutput>

@property (nonatomic, strong) ProductDetailsCoordinator *dataCoordinator;
@property (nonatomic, strong) Product *product;

@end
