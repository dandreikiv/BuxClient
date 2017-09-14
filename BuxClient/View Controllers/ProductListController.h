//
//  ProductListController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UITableView.h>

@class Product;
@protocol ProductListControllerDelegate;

@interface ProductListController : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <ProductListControllerDelegate> delegate;

@property (nonatomic, strong) NSArray <Product *> *products;

@end
