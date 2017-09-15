//
//  ProductDetailsViewController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsDataCoordinatorOutput.h"

@class Product;
@class ProductDetailsDataCoordinator;

@interface ProductDetailsViewController : UIViewController <ProductDetailsDataCoordinatorOutput>

@property (nonatomic, strong) ProductDetailsDataCoordinator *dataCoordinator;
@property (nonatomic, strong) Product *product;

@end
