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
#import "ReachabilityStatus.h"
#import "BUXError.h"

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

- (void)dealloc {
	[self.reachability removeObserver:self];
}

- (void)retrieveProducts {
	[self.networkManager performRequest:[self.requestBuilder productsRequest] completion:^(NSData *data, NSError *error) {
		if (error) {
			[self presentError:error];
		}
		else {
			[self storeReceivedProductsAndUpdateList:data];
		}
	}];
}

- (void)presentError:(NSError *)error {
	if ([self.coordinatorOutput respondsToSelector:@selector(presentError:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.coordinatorOutput presentError:error];
		});
	}
}

- (void)storeReceivedProductsAndUpdateList:(NSData *)data {
	id json = [NSJSONSerialization JSONObjectWithData:data
											  options:NSJSONReadingMutableContainers
												error:NULL];
	
	NSError *error = [self errorFromJSON:json];
	if (error) {
		[self presentError:error];
	}
	else {
		for (NSDictionary *productDictionary in json) {
			Product *product = [[Product alloc] initWithDictionary:productDictionary];
			[self.dataStorage storeProduct:product];
		}
		
		if ([self.coordinatorOutput respondsToSelector:@selector(updateListWithProducts:)]) {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.coordinatorOutput updateListWithProducts:self.dataStorage.allProducts];
			});
		}
	}
}

- (NSError *)errorFromJSON:(id)json {
	NSError *error = nil;
	if ([json isKindOfClass:[NSDictionary class]]) {
		NSDictionary *dictionary = (NSDictionary *)json;
		error = [BUXError errorWithErrorCode:dictionary[@"errorCode"]];
	}
	
	return error;
}

#pragma mark - ReachabilityObserver -

- (void)networkReachabilityStatusChanged:(Reachability *)reachability {
	if (reachability.connectionAvailable == NO) {
		[self presentError:[BUXError reachabilityError]];
	} else {
		if ([self.dataStorage allProducts].count == 0) {
			[self retrieveProducts];
		}
	}
}

@end
