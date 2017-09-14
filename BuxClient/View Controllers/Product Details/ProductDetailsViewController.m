//
//  ProductDetailsViewController.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "Product.h"
#import "DataCoordinator.h"
#import "DataCoordinatorOutput.h"

@interface ProductDetailsViewController () <DataCoordinatorProductDetailsOutput>

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupUI];
}

- (void)setupUI {
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.dataCoordinator.productDetailsOutput = self;
	[self.dataCoordinator subscribeToProduct:self.product];
	NSLog(@"subscribeTo:%@", self.product);
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.dataCoordinator.productDetailsOutput = nil;
	[self.dataCoordinator unsubscribeFromProduct:self.product];
	NSLog(@"unsubscribeFrom:%@", self.product);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataCoordinatorProductDetailsOutput -

- (void)updateWithProduct:(Product *)product {
	
}

@end
