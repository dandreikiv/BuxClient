//
//  DataCoordinator.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "DataCoordinator.h"
#import "DataCoordinatorOutput.h"
#import "NetworkManager.h"
#import "Product.h"
#import "ProductListViewModel.h"
#import "RequestBuilderProtocol.h"
#import "WebSocketManager.h"

@interface DataCoordinator()

@property (nonatomic, strong) NSMutableArray <Product *> * products;

@property (nonatomic, strong) id <RequestBuilderProtocol> requestBuilder;
@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) WebSocketManager *webSocketManager;

@end

@implementation DataCoordinator

- (instancetype)initWithRequsetBuilder:(id <RequestBuilderProtocol>)requestBuilder {
	self = [super init];
	if (self) {
		self.requestBuilder = requestBuilder;
		
		self.products = [NSMutableArray new];
		self.networkManager = [NetworkManager new];
		self.webSocketManager = [[WebSocketManager alloc] initWithRequestBuilder:self.requestBuilder];
	}
	return self;
}

- (void)retrieveProducts {
	[self.networkManager performRequest:[self.requestBuilder productsRequest] completion:^(NSData *data, NSError *error) {
		
		NSArray *productsCollection = [NSJSONSerialization JSONObjectWithData:data
																  options:NSJSONReadingMutableContainers
																	error:NULL];
		for (NSDictionary *productDictionary in productsCollection) {
			Product *product = [[Product alloc] initWithDictionary:productDictionary];
			[self.products addObject:product];
		}
		
		if ([self.coordinatorOutput respondsToSelector:@selector(updateListWithProducts:)]) {
			[self.coordinatorOutput updateListWithProducts:[self productViewModelsFromProducts]];
		}
	}];
}

- (NSArray <ProductListViewModel *> *)productViewModelsFromProducts {
	NSMutableArray *viewModels = [[NSMutableArray alloc] initWithCapacity:self.products.count];
	for (Product *product in self.products) {
		[viewModels addObject:[[ProductListViewModel alloc] initWithProduct:product]];
	}
	return [viewModels copy];
	
}

@end
