//
//  ProductListViewModel.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Product;

@interface ProductListViewModel : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *displayName;
@property (nonatomic, copy, readonly, nonnull) NSString *category;

- (nullable instancetype)initWithProduct:(nonnull Product *)product;

@end
