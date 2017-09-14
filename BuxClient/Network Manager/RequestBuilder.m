//
//  RequestBuilder.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "RequestBuilder.h"
#import "ConnectionConfiguration.h"

@interface RequestBuilder()

@property (nonatomic, strong) ConnectionConfiguration *configuration;

@end

@implementation RequestBuilder

- (instancetype)initWithConfigurataion:(ConnectionConfiguration *)conf {
	self = [super init];
	if (self) {
		self.configuration = conf;
	}
	return self;
}

@end
