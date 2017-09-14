//
//  RequestBuilder.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBuilderProtocol.h"

@class ConnectionConfiguration;

@interface RequestBuilder : NSObject <RequestBuilderProtocol>

- (instancetype)initWithConfigurataion:(ConnectionConfiguration *)conf;

@end
