//
//  Price.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Price : NSObject

@property (nonatomic, strong, readonly) NSNumber *amount;
@property (nonatomic, copy, readonly) NSString *currency;
@property (nonatomic, assign, readonly) NSUInteger decimals;

- (instancetype)initWithPriceDictionary:(NSDictionary *)dictionary;

@end
