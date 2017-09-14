//
//  ProductListController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UITableView.h>

@class Product;

@interface ProductListController : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray <Product *> *products;

@end
