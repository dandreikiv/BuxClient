//
//  ConnectionConfiguration.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionConfiguration : NSObject

@property (nonatomic, strong, readonly, nullable) NSURL *baseURL;
@property (nonatomic, strong, readonly, nullable) NSURL *webSocketURL;
@property (nonatomic, copy, readonly, nullable) NSString *authorizationToken;

@end
