//
//  WebSocketErrorMessage.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebSocketErrorMessage : NSObject

@property (nonatomic, strong, readonly, nullable) NSError *error;

- (nullable instancetype)initWithDictionary:(nullable NSDictionary *)dictionary;

@end
