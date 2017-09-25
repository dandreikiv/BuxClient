//
//  ProductDetailsCoordinator.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductDetailsCoordinator.h"
#import "ProductDetailsActions.h"
#import "Product.h"
#import "Price.h"
#import "DataStorageProtocol.h"
#import "NetworkManager.h"
#import "RequestBuilderProtocol.h"
#import "WebSocketManager.h"
#import "WebSocketManagerDelegate.h"
#import "WebSocketStatusViewModel.h"
#import "Reachability.h"
#import "BUXError.h"
#import "ReachabilityObserver.h"

@interface ProductDetailsCoordinator () <WebSocketManagerDelegate, ReachabilityObserver>

@property (nonatomic, strong) id <RequestBuilderProtocol> requestBuilder;
@property (nonatomic, strong) id <DataStorageProtocol> dataStorage;
@property (nonatomic, strong) WebSocketManager *webSocketManager;
@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) Product *productToSubscribe;
@property (nonatomic, strong) Reachability *reachability;

@end


@implementation ProductDetailsCoordinator

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder
						   dataStorage:(id <DataStorageProtocol>)dataStorage
{
	self = [super init];
	if (self) {
		self.requestBuilder = requestBuilder;
		self.dataStorage = dataStorage;
		
		self.webSocketManager = [[WebSocketManager alloc] initWithRequestBuilder:self.requestBuilder];
		self.webSocketManager.delegate = self;
		
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

- (void)retrieveDetailsWithProduct:(Product *)product {
	NSURLRequest *request = [self.requestBuilder productDetailsRequestWithProduct:product];
	[self.networkManager performRequest:request completion:^(NSData *data, NSError *error) {
		if (error) {
			[self presentError:error];
		}
		else {
			NSDictionary *productDictionary = [NSJSONSerialization JSONObjectWithData:data
																			  options:NSJSONReadingMutableContainers
																				error:NULL];
			Product *details = [[Product alloc] initWithDictionary:productDictionary];
			[self.dataStorage update:details withId:details.productId];
			if ([self.coordinatorOutput respondsToSelector:@selector(updateWithProduct:)]) {
				dispatch_async(dispatch_get_main_queue(), ^{
					[self.coordinatorOutput updateWithProduct:details];
				});
			}
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

- (void)subscribeToProduct:(Product *)product {
	if (self.webSocketManager.webSocketStatus == WebsocketStatusConnected) {
		[self.webSocketManager subscribeToProuduct:product];
	}
	else {
		self.productToSubscribe = product;
	}
}

- (void)unsubscribeFromProduct:(Product *)product {
	[self.webSocketManager unsubscribeFromProduct:product];
}

- (void)requestWebSocketState {
	[self dispatchWebSocketStatusChange:self.webSocketManager.webSocketStatus];
}

- (void)dispatchWebSocketStatusChange:(WebsocketStatus)status {
	if ([self.coordinatorOutput respondsToSelector:@selector(updateWithWebSocketStatus:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			WebSocketStatusViewModel *viewModel = [[WebSocketStatusViewModel alloc] initWithStatus:status];
			[self.coordinatorOutput updateWithWebSocketStatus:viewModel];
		});
	}
}

#pragma mark - WebSocketManagerDelegate -

- (void)webSocketStatusDidChange:(WebsocketStatus)status {
	[self dispatchWebSocketStatusChange:status];
}

- (void)didGetQuoteAmount:(NSNumber *)amount forProductWithId:(NSString *)productId {
	Product *product = [self.dataStorage productWithId:productId];
	[product.currentPrice updateAmount:amount];
	
	if ([self.coordinatorOutput respondsToSelector:@selector(updateWithProduct:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.coordinatorOutput updateWithProduct:product];
		});
	}
}

- (void)didConnect {
	if (self.productToSubscribe) {
		[self subscribeToProduct:self.productToSubscribe];
	}
}

- (void)didFailedToConnectWithError:(NSError *)error {
	if ([self.coordinatorOutput respondsToSelector:@selector(presentError:)]) {
		[self.coordinatorOutput presentError:error];
	}
}

- (void)networkReachabilityStatusChanged:(Reachability *)reachability {
	if (reachability.connectionAvailable == NO) {
		[self presentError:[BUXError reachabilityError]];
	} else {
		[self.webSocketManager openSocket];
	}
}

@end
