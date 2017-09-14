//
//  Price.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Price : NSObject

@property (nonatomic, copy, readonly, nullable) NSString *currency;
@property (nonatomic, strong, readonly, nullable) NSNumber *amount;
@property (nonatomic, assign, readonly) NSUInteger decimals;

- (nullable instancetype)initWithPriceDictionary:(nullable NSDictionary *)dictionary;

- (void)updateAmount:(NSNumber *)amount;

@end
