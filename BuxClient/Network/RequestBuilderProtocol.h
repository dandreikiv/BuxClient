//
//  RequestBuilderProtocol.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@class Product;

@protocol RequestBuilderProtocol <NSObject>

/**
 Creates a request to get a list of products.

 @return a NSURLRequest instance.
 */
- (nullable NSURLRequest *)productsRequest;


/**
 Creates a request to get detailed information about given product.

 @param product a product for which details should be retrieved.
 @return a NSURLRequest instance.
 */
- (nullable NSURLRequest *)productDetailsRequestWithProduct:(nonnull Product *)product;


/**
 Creates a request to connect to websocket server.

 @return a NSURLRequest instance.
 */
- (nullable NSURLRequest *)webSocketRequest;

@end
