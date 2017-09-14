//
//  Product.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Price;

@interface Product : NSObject

@property (nonatomic, copy, readonly, nullable) NSString *symbol;
@property (nonatomic, copy, readonly, nullable) NSString *displayName;
@property (nonatomic, copy, readonly, nullable) NSString *productId;
@property (nonatomic, copy, readonly, nullable) NSString *category;
@property (nonatomic, copy, readonly, nullable) NSString *quoteCurrency;
@property (nonatomic, strong, readonly, nullable) Price *currentPrice;
@property (nonatomic, strong, readonly, nullable) Price *closingPrice;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end
