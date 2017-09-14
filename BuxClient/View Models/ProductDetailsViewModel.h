//
//  ProductDetailsViewModel.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@interface ProductDetailsViewModel : NSObject

@property (nonatomic, copy, readonly, nullable) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *currentPrice;
@property (nonatomic, copy, readonly, nullable) NSString *priceChange;

- (nullable instancetype)initWithProduct:(nonnull Product *)product;

- (void)updateWithProduct:(nonnull Product *)product;

@end
