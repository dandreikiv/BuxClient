//
//  ProductListController.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductListController.h"
#import "Product.h"
#import "ProductListCell.h"
#import "ProductListControllerDelegate.h"
#import "ProductListViewModel.h"
#import "ProductListSectionHeaderView.h"

const CGFloat kProductListCellHeight = 60.0f;
const CGFloat kProductListHeaderHeight = 24.0f;

@interface ProductListController()

@property (nonatomic, strong) NSArray <NSString *> *categories;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableArray *> *sections;

@end

@implementation ProductListController

- (instancetype)init {
	self = [super init];
	if (self) {
		self.sections = [NSMutableDictionary new];
	}
	return self;
}

- (void)setProducts:(NSArray<Product *> *)products {
	// Clean everything in order to avoid duplications.
	[self.sections removeAllObjects];
	
	for (Product *product in products) {
		NSMutableArray *array = self.sections[product.category];
		if (array == nil) {
			array = [NSMutableArray new];
			self.sections[product.category] = array;
		}
		[array addObject:product];
	}
	
	self.categories = [self.sections.allKeys sortedArrayUsingSelector:@selector(compare:options:)];
	
	// Sort products inside each category.
	for (NSString *key in self.sections.allKeys) {
		NSMutableArray *products = self.sections[key];
		[products sortUsingComparator:^NSComparisonResult(Product *product, Product *otherProduct) {
			return [product.displayName compare:otherProduct.displayName];
		}];
	}
}

#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.categories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *category = self.categories[section];
	NSArray *rows = self.sections[category];
	return [rows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ProductListCell identifier]];
	if (cell == nil) {
		cell = [[ProductListCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:[ProductListCell identifier]];
	}
	return cell;
}

#pragma mark - UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if ([self.delegate respondsToSelector:@selector(presentDetailsForProduct:)]) {
		[self.delegate presentDetailsForProduct:[self productAtIndexPath:indexPath]];
	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	ProductListCell *productCell = (ProductListCell *)cell;
	
	Product *product = [self productAtIndexPath:indexPath];
	productCell.viewModel = [[ProductListViewModel alloc] initWithProduct:product];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return kProductListCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return kProductListHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	ProductListSectionHeaderView *headerView = [ProductListSectionHeaderView new];
	[headerView setTitleText:self.categories[section]];
	return headerView;
}

#pragma mark - Private Methods -

- (Product *)productAtIndexPath:(NSIndexPath *)indexPath {
	NSString *category = self.categories[indexPath.section];
	NSArray *rows = self.sections[category];
	assert(rows != nil);
	return rows[indexPath.row];
}

@end
