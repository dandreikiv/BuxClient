//
//  ViewController.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductDetailsViewController.h"
#import "Product.h"
#import "DataCoordinator.h"
#import "ProductListController.h"
#import "ProductListControllerDelegate.h"

@interface ProductListViewController () <ProductListControllerDelegate>

@property (nonatomic, strong) UITableView *productsList;
@property (nonatomic, strong) ProductListController *productListController;

@end

@implementation ProductListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupUI];
	[self.dataCoordinator retrieveProducts];
}

- (void)setupUI {
	self.view.backgroundColor = [UIColor whiteColor];
	self.productsList = [UITableView new];
	self.productsList.separatorInset = UIEdgeInsetsZero;
	
	self.productListController = [ProductListController new];
	self.productListController.delegate = self;
	
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
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - DataCoordinatorProductListOutput -

- (void)updateListWithProducts:(NSArray <Product *> *)products {
	self.productListController.products = products;
	[self.productsList reloadData];
}

- (void)presentRetrieveProductsError:(NSError *)error {
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Bux Client", nil)
																   message:error.localizedDescription
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok"
													 style:UIAlertActionStyleDefault
												   handler:nil];
	[alert addAction:action];
	[self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - ProductListControllerDelegate -

- (void)presentDetailsForProduct:(Product *)product {
	ProductDetailsViewController *controller = [ProductDetailsViewController new];
	controller.product = product;
	controller.dataCoordinator = self.dataCoordinator;
	[self.navigationController pushViewController:controller animated:YES];
}

@end
