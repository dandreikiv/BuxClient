//
//  BUXError.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "BUXError.h"
#import "BUXErrorCodes.h"

NSString *const BUXClientDomainError = @"BUXClientDomainError";

@implementation BUXError

static NSDictionary *errorsMap = nil;

+ (void)initialize {
	errorsMap = @{
				  @"AUTH_008"   : (NSError *) ^{ return [self tokenExpiredError];      },
				  @"AUTH_007"   : (NSError *) ^{ return [self tokenInvalidError];      },
				  @"AUTH_014"   : (NSError *) ^{ return [self permissionError]; 	   },
				  @"AUTH_009"   : (NSError *) ^{ return [self authHeaderMissingError]; },
				  @"TRADING_002": (NSError *) ^{ return [self authHeaderMissingError]; }
				  };
}

+ (NSError *)tokenExpiredError {
	return [NSError errorWithDomain:BUXClientDomainError
							   code:ErrorCodeAuthorizationTokenExpired
						   userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Authorization Token expired", nil)}];
}

+ (NSError *)tokenInvalidError {
	return [NSError errorWithDomain:BUXClientDomainError
							   code:ErrorCodeAccessTokenNotValid
						   userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Authorization Token is not valid", nil)}];
}

+ (NSError *)permissionError {
	return [NSError errorWithDomain:BUXClientDomainError
							   code:ErrorCodeNotSufficientPermissions
						   userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"User does not have sufficient permissions to perform this action", nil)}];
}

+ (NSError *)authHeaderMissingError {
	return [NSError errorWithDomain:BUXClientDomainError
							   code:ErrorCodeAuthorizationHeaderMissing
						   userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Missing Authorization header", nil)}];
}

+ (NSError *)unexpectedError {
	return [NSError errorWithDomain:BUXClientDomainError
							   code:ErrorCodeAuthorizationHeaderMissing
						   userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Unexpected Error", nil)}];
}


+ (NSError *)errorWithErrorCode:(NSString *)code {
	NSError *(^createError)(void) = errorsMap[code];
	return createError ? createError() : nil;
}

+ (NSError *)reachabilityError {
	return [NSError errorWithDomain:BUXClientDomainError
							   code:ErrorCodeNetworkConnectionIssue
						   userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Network connection issue", nil)}];
}

@end
