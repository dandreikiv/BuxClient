//
//  BUXErrorCodes.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

typedef NS_ENUM (NSUInteger, ErrorCode) {
	ErrorCodeAccessTokenNotValid = 7,
	ErrorCodeNotSufficientPermissions = 14,
	ErrorCodeAuthorizationHeaderMissing = 9,
	ErrorCodeAuthorizationTokenExpired = 8,
	ErrorCodeUnexpected
};
