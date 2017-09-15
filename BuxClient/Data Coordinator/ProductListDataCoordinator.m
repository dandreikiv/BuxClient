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
#import "Reachability.h"
#import "ReachabilityObserver.h"

@interface ProductListDataCoordinator() <ReachabilityObserver>

@property (nonatomic, strong) id <RequestBuilderProtocol> requestBuilder;
@property (nonatomic, strong) id <DataStorageProtocol> dataStorage;
@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) Reachability *reachability;

@end

@implementation ProductListDataCoordinator

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder
						   dataStorage:(id <DataStorageProtocol>)dataStorage
{
	self = [super init];
	if (self) {
		self.requestBuilder = requestBuilder;
		self.dataStorage = dataStorage;
		
		self.networkManager = [NetworkManager new];
		self.reachability = [Reachability reachabilityForInternetConnection];
		[self.reachability addObserver:self];
		[self.reachability startNotifier];
	}
	return self;
}

- (void)retrieveProducts {
	[self.networkManager performRequest:[self.requestBuilder productsRequest] completion:^(NSData *data, NSError *error) {
		if (error) {
			[self presentRetrieveProductsError:error];
		}
		else {
			[self storeReceivedProductsAndUpdateList:data];
		}
	}];
}

- (void)presentRetrieveProductsError:(NSError *)error {
	if ([self.coordinatorOutput respondsToSelector:@selector(presentRetrieveProductsError:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.coordinatorOutput presentRetrieveProductsError:error];
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
	}
	
	if ([self.coordinatorOutput respondsToSelector:@selector(updateListWithProducts:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.coordinatorOutput updateListWithProducts:self.dataStorage.allProducts];
		});
	}
}

#pragma mark - ReachabilityObserver -

- (void)networkReachabilityStatusChanged:(Reachability *)reachability {
	NSLog(@"networkReachabilityStatusChanged");
}

@end
