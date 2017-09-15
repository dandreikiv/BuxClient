//
//  DataCoordinator.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@protocol ProductListDataCoordinatorOutput;
@protocol RequestBuilderProtocol;
@protocol DataStorageProtocol;

@interface ProductListDataCoordinator : NSObject

@property (nonatomic, strong, readonly, nullable) id <DataStorageProtocol> dataStorage;
@property (nonatomic, weak, nullable) id <ProductListDataCoordinatorOutput> coordinatorOutput;

- (nullable instancetype)initWithRequestBuilder:(nonnull id <RequestBuilderProtocol>)requestBuilder
									dataStorage:(nonnull id <DataStorageProtocol>)dataStorage;

- (void)retrieveProducts;

@end
