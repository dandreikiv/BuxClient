//
//  ProductDetailsViewController.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "Product.h"
#import "Price.h"
#import "DataCoordinator.h"
#import "DataCoordinatorOutput.h"
#import "MarketClosedView.h"
#import "ProductDetailsViewModel.h"

@interface ProductDetailsViewController () <DataCoordinatorProductDetailsOutput>

@property (nonatomic, strong) MarketClosedView *marketClosedView;
@property (nonatomic, strong) UILabel *market;
@property (nonatomic, strong) UILabel *currentPrice;
@property (nonatomic, strong) UILabel *priceChange;

@property (nonatomic, strong) ProductDetailsViewModel *viewModel;

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupUI];
}

- (void)setupUI {
	self.view.backgroundColor = [UIColor whiteColor];
	self.marketClosedView = [MarketClosedView new];
	
	self.market = [UILabel new];
	self.market.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:28.0];
	self.market.textColor = [UIColor blackColor];
	self.market.textAlignment = NSTextAlignmentCenter;
	self.market.text = self.viewModel.name;
	[self.view addSubview:self.market];
	
	self.market.translatesAutoresizingMaskIntoConstraints = NO;
	[self.market.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:120.0f].active = YES;
	[self.market.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	
	
	self.currentPrice = [UILabel new];
	self.currentPrice.font = [UIFont fontWithName:@"Courier-Bold" size:24.0];
	self.currentPrice.textColor = [UIColor blackColor];
	self.currentPrice.textAlignment = NSTextAlignmentCenter;
	self.currentPrice.text = self.viewModel.currentPrice;
	[self.view addSubview:self.currentPrice];
	
	self.currentPrice.translatesAutoresizingMaskIntoConstraints = NO;
	[self.currentPrice.topAnchor constraintEqualToAnchor:self.market.bottomAnchor constant:30.0f].active = YES;
	[self.currentPrice.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
	
	
	self.priceChange = [UILabel new];
	self.priceChange.font = [UIFont fontWithName:@"Courier-Bold" size:24.0];
	self.priceChange.textColor = [UIColor blackColor];
	self.priceChange.textAlignment = NSTextAlignmentCenter;
	self.priceChange.text = self.viewModel.priceChange;
	[self.view addSubview:self.priceChange];
	
	self.priceChange.translatesAutoresizingMaskIntoConstraints = NO;
	[self.priceChange.topAnchor constraintEqualToAnchor:self.currentPrice.bottomAnchor constant:10.0f].active = YES;
	[self.priceChange.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (self.product.marketOpen == NO) {
		[self presentMarkedClosedView];
	}
	self.dataCoordinator.productDetailsOutput = self;
	[self.dataCoordinator subscribeToProduct:self.product];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	self.dataCoordinator.productDetailsOutput = nil;
	[self.dataCoordinator unsubscribeFromProduct:self.product];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentMarkedClosedView {
	self.marketClosedView.product = self.product;
	self.marketClosedView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.marketClosedView];
	
	[self.marketClosedView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
	[self.marketClosedView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
	[self.marketClosedView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
	[self.marketClosedView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)setProduct:(Product *)product {
	_product = product;
	if (self.viewModel == nil) {
		self.viewModel = [[ProductDetailsViewModel alloc] initWithProduct:product];
	}
	else {
		[self.viewModel updateWithProduct:product];
	}
}

#pragma mark - DataCoordinatorProductDetailsOutput -

- (void)updateWithProduct:(Product *)product {
	[self.viewModel updateWithProduct:product];
	
	self.currentPrice.text = self.viewModel.currentPrice;
	self.priceChange.text = self.viewModel.priceChange;
}

@end
