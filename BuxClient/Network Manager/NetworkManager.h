//
//  NetworkManager.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@interface NetworkManager : NSObject

- (void)retrieveProductsWithCompletion:(void (^)(NSData *, NSError *))completion;

- (void)retrieveDetailsWithProduct:(Product *)product
						completion:(void (^)(NSData *, NSError *))completion;

@end
