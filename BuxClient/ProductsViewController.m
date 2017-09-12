//
//  ProductsViewController.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductsViewController.h"
#import "Price.h"
#import "Product.h"
#import "InteractorInput.h"

@interface ProductsViewController ()

@end

@implementation ProductsViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor whiteColor];
	[self.interactor retreaveProducts];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Interactor Output -

- (void)updateWithProducts:(NSArray<Product *> *)products {
	NSLog(@"updateWithProducts: %@", products);
}

- (void)presentErrorMessage:(NSError *)error {
	NSLog(@"presentErrorMessage: %@", error.localizedDescription);
}

@end
