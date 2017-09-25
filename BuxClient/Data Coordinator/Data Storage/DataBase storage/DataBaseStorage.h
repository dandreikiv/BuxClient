//
//  DataBaseStorage.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 25/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataStorageProtocol.h"

@class RLMRealmConfiguration;

@interface DataBaseStorage : NSObject <DataStorageProtocol>

- (instancetype)initWithConfiguration:(RLMRealmConfiguration *)configuration;

- (void)cleanStorage;

@end
