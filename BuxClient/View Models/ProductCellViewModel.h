//
//  ProductCellViewModel.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@interface ProductCellViewModel : NSObject

@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, copy) NSString *closingPrice;
@property (nonatomic, copy) NSString *priceChange;

- (instancetype)initWithProuduct:(Product *)product;

@end
