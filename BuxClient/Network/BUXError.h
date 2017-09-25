//
//  BUXError.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * _Nonnull const BUXClientDomainError;

@interface BUXError : NSObject

/**
 Creates an instance of NSError class with network specific error.

 @return an error object
 */
+ (nonnull NSError *)reachabilityError;

/**
 Creates an instance of NSError class depending on given error code.

 @param code an error code.
 @return an error object
 */
+ (nullable NSError *)errorWithErrorCode:(nullable NSString *)code;

@end
