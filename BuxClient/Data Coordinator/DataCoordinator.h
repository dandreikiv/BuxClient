//
//  DataCoordinator.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@protocol DataCoordinatorProductListOutput;
@protocol DataCoordinatorProductDetailsOutput;
@protocol RequestBuilderProtocol;

@interface DataCoordinator : NSObject

@property (nonatomic, weak) id <DataCoordinatorProductListOutput> productListOutput;
@property (nonatomic, weak) id <DataCoordinatorProductDetailsOutput> productDetailsOutput;

- (instancetype)initWithRequsetBuilder:(id <RequestBuilderProtocol>)requestBuilder;

- (void)retrieveProducts;
- (void)retrieveDetailsWithProduct:(Product *)product;

- (void)subscribeToProduct:(Product *)product;
- (void)unsubscribeFromProduct:(Product *)product;

@end
