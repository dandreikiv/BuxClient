//
//  ProductDetailsDataCoordinator.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductDetailsDataCoordinator.h"
#import "ProductDetailsDataCoordinatorOutput.h"
#import "Product.h"
#import "Price.h"
#import "DataStorageProtocol.h"
#import "RequestBuilderProtocol.h"
#import "WebSocketManager.h"
#import "WebSocketManagerDelegate.h"

@interface ProductDetailsDataCoordinator () <WebSocketManagerDelegate>

@property (nonatomic, strong) id <RequestBuilderProtocol> requestBuilder;
@property (nonatomic, strong) id <DataStorageProtocol> dataStorage;
@property (nonatomic, strong) WebSocketManager *webSocketManager;

@end


@implementation ProductDetailsDataCoordinator

- (instancetype)initWithRequestBuilder:(id <RequestBuilderProtocol>)requestBuilder
						   dataStorage:(id <DataStorageProtocol>)dataStorage
{
	self = [super init];
	if (self) {
		self.requestBuilder = requestBuilder;
		self.dataStorage = dataStorage;
		
		self.webSocketManager = [[WebSocketManager alloc] initWithRequestBuilder:self.requestBuilder];
		self.webSocketManager.delegate = self;
	}
	return self;
}

- (void)dealloc {
	NSLog(@"dealloc: %@", NSStringFromClass([self class]));
}

- (void)subscribeToProduct:(Product *)product {
	[self.webSocketManager subscribeToProuduct:product];
}

- (void)unsubscribeFromProduct:(Product *)product {
	[self.webSocketManager unsubscribeFromProduct:product];
}

#pragma mark - WebSocketManagerDelegate - 

- (void)didConnect {
	if ([self.productDetailsOutput respondsToSelector:@selector(webSocketDidConnect)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.productDetailsOutput webSocketDidConnect];
		});
	}
}

- (void)didFailedToConnectWithError:(NSError *)error {
	
}

- (void)didGetQuoteAmount:(NSNumber *)amount forProductWithId:(NSString *)productId {
	Product *product = [self.dataStorage productWithId:productId];
	[product.currentPrice updateAmount:amount];
	
	if ([self.productDetailsOutput respondsToSelector:@selector(updateWithProduct:)]) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self.productDetailsOutput updateWithProduct:product];
		});
	}
}

@end
