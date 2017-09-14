//
//  ViewController.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductsListViewController.h"
#import "ProductListViewModel.h"
#import "DataCoordinator.h"

@interface ProductsListViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ProductsListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self.dataCoordinator retrieveProducts];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)updateListWithProducts:(NSArray <ProductListViewModel *> *)products {
	NSLog(@"Products:%@", products);
}

@end
