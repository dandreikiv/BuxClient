//
//  ProductDetailsViewController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@class DataCoordinator;

@interface ProductDetailsViewController : UIViewController

@property (nonatomic, strong) DataCoordinator *dataCoordinator;
@property (nonatomic, strong) Product *product;

@end
