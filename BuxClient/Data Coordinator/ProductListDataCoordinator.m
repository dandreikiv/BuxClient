//
//  ProductListDataCoordinator.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductListDataCoordinator.h"
#import "ProductListDataCoordinatorOutput.h"
#import "DataStorageProtocol.h"
#import "NetworkManager.h"
#import "Product.h"
#import "Price.h"
#import "ProductListViewModel.h"
#import "RequestBuilderProtocol.h"
//#import "WebSocketManager.h"
//#import "WebSocketManagerDelegate.h"

@interface ProductListDataCoordinator()

//@property (nonatomic, strong) NSMutableArray <Product *> * products;

@property (nonatomic, strong) id <RequestBuilderProtocol> requestBuilder;
@property (nonatomic, strong) id <DataStorageProtocol> dataStorage;
@property (nonatomic, strong) NetworkManager *networkManager;
//@property (nonatomic, strong) WebSocketManager *webSocketManager;

@end

@implementation ProductListDataCoordinator

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder
						   dataStorage:(id <DataStorageProtocol>)dataStorage
{
	self = [super init];
	if (self) {
		self.requestBuilder = requestBuilder;
		self.dataStorage = dataStorage;
		
//		self.products = [NSMutableArray new];
		self.networkManager = [NetworkManager new];
//		self.webSocketManager = [[WebSocketManager alloc] initWithRequestBuilder:self.requestBuilder];
//		self.webSocketManager.delegate = self;
	}
	return self;
}

- (void)retrieveProducts {
	[self.networkManager performRequest:[self.requestBuilder productsRequest] completion:^(NSData *data, NSError *error) {
		if (error) {
			[self presentRetrieveProductsError:error];
		}
		else {
//			[self.products removeAllObjects];
			[self storeReceivedProductsAndUpdateList:data];
		}
	}];
}

- (void)retrieveDetailsWithProduct:(Product *)product {
//	NSURLRequest *request = [self.requestBuilder productDetailsRequestWithProduct:product];
//	[self.networkManager performRequest:request completion:^(NSData *data, NSError *error) {
//		if (error) {
//			[self presentRetrieveProductsError:error];
//		}
//		else {
//			NSDictionary *productDictionary = [NSJSONSerialization JSONObjectWithData:data
//																			  options:NSJSONReadingMutableContainers
//																				error:NULL];
//			Product *details = [[Product alloc] initWithDictionary:productDictionary];
//			if ([self.productDetailsOutput respondsToSelector:@selector(updateWithProduct:)]) {
//				dispatch_async(dispatch_get_main_queue(), ^{
//					[self.productDetailsOutput updateWithProduct:details];
//				});
//			}
//		}
//	}];
}

//- (void)subscribeToProduct:(Product *)product {
//	[self.webSocketManager subscribeToProuduct:product];
//}
//
//- (void)unsubscribeFromProduct:(Product *)product {
//	[self.webSocketManager unsubscribeFromProduct:product];
//}

- (void)presentRetrieveProductsError:(NSError *)error {
	if ([self.productListOutput respondsToSelector:@selector(presentRetrieveProductsError:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.productListOutput presentRetrieveProductsError:error];
		});
	}
}

- (void)storeReceivedProductsAndUpdateList:(NSData *)data {
	NSArray *productsCollection = [NSJSONSerialization JSONObjectWithData:data
																  options:NSJSONReadingMutableContainers
																	error:NULL];
	for (NSDictionary *productDictionary in productsCollection) {
		Product *product = [[Product alloc] initWithDictionary:productDictionary];
		[self.dataStorage storeProduct:product];
//		[self.products addObject:product];
	}
	
	if ([self.productListOutput respondsToSelector:@selector(updateListWithProducts:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.productListOutput updateListWithProducts:self.dataStorage.allProducts];
		});
	}
}

//#pragma mark - WebSocketManagerDelegate -
//
//- (void)didGetQuoteAmount:(NSNumber *)amount forProductWithId:(NSString *)productId {
//	Product *product = [self productWithId:productId];
//	[product.currentPrice updateAmount:amount];
//	
////	if ([self.productDetailsOutput respondsToSelector:@selector(updateWithProduct:)]) {
////		dispatch_async(dispatch_get_main_queue(), ^{
////			[self.productDetailsOutput updateWithProduct:product];
////		});
////	}
//}
//
//- (Product *)productWithId:(NSString *)productId {
//	NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"productId = %@", productId];
//	return [self.products filteredArrayUsingPredicate:filterPredicate].firstObject;
//}

@end
