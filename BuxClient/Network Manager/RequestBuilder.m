//
//  RequestBuilder.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "RequestBuilder.h"
#import "ConnectionConfiguration.h"

static NSString *const kProductsPath = @"core/16/products/";

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

- (NSURLRequest *)productsRequest {
	NSURL *url = [NSURL URLWithString:kProductsPath relativeToURL:self.configuration.baseURL];
	return [self requestWithURL:url];
}

- (NSURLRequest *)requestWithURL:(NSURL *)url {
	NSParameterAssert(url);
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setValue:self.configuration.authorizationToken forHTTPHeaderField:@"Authorization"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"nl-NL,en;q=0.8" forHTTPHeaderField:@"Accept-Language"];
	return [request copy];
}

@end
