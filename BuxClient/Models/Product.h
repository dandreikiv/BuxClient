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

@property (nonatomic, copy, readonly) NSString *symbol;
@property (nonatomic, copy, readonly) NSString *displayName;
@property (nonatomic, copy, readonly) NSString *productId;
@property (nonatomic, copy, readonly) NSString *category;
@property (nonatomic, copy, readonly) NSString *productDescription;
@property (nonatomic, copy, readonly) NSString *quoteCurrency;
@property (nonatomic, strong, readonly) Price *currentPrice;
@property (nonatomic, strong, readonly) Price *closingPrice;

- (instancetype)initWithProductDictionary:(NSDictionary *)dictionary;

- (void)updateCurrentPriceWithAmount:(NSNumber *)amount;

@end
