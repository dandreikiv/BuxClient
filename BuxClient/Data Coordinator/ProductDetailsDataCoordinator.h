//
//  ProductDetailsDataCoordinator.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@protocol ProductDetailsDataCoordinatorOutput;
@protocol DataStorageProtocol;
@protocol RequestBuilderProtocol;

@interface ProductDetailsDataCoordinator : NSObject

@property (nonatomic, weak, nullable) id <ProductDetailsDataCoordinatorOutput> productDetailsOutput;

- (nullable instancetype)initWithRequestBuilder:(nonnull id <RequestBuilderProtocol>)requestBuilder
									dataStorage:(nonnull id <DataStorageProtocol>)dataStorage;

- (void)subscribeToProduct:(nonnull Product *)product;
- (void)unsubscribeFromProduct:(nonnull Product *)product;

@end
