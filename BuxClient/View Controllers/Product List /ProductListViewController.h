//
//  ProductListViewController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListCoordinatorOutput.h"

@class ProductListCoordinator;

@interface ProductListViewController : UIViewController <ProductListCoordinatorOutput>

@property (nonatomic, strong) ProductListCoordinator *dataCoordinator;

@end

