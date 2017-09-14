//
//  ViewController.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductsListViewController.h"
#import "Product.h"
#import "DataCoordinator.h"
#import "ProductListController.h"

@interface ProductsListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *productsList;
@property (nonatomic, strong) ProductListController *productListController;

@end

@implementation ProductsListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupUI];
}

- (void)setupUI {
	self.view.backgroundColor = [UIColor whiteColor];
	self.productsList = [UITableView new];
	self.productsList.separatorInset = UIEdgeInsetsZero;
	
	self.productListController = [ProductListController new];
	
	self.productsList.delegate = self.productListController;
	self.productsList.dataSource = self.productListController;
	
	[self.view addSubview:self.productsList];
	self.productsList.translatesAutoresizingMaskIntoConstraints = NO;
	[self.productsList.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
	[self.productsList.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
	[self.productsList.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
	[self.productsList.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self.dataCoordinator retrieveProducts];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)updateListWithProducts:(NSArray <Product *> *)products {
	self.productListController.products = products;
	[self.productsList reloadData];
}

@end
