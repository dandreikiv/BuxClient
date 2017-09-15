//
//  BUXError.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const BUXClientDomainError;

@interface BUXError : NSObject

+ (NSError *)errorWithErrorCode:(NSString *)code;

@end
