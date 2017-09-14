//
//  NetworkManager.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (void)performRequest:(NSURLRequest *)request completion:(void (^)(NSData *, NSError *))completion {
	completion = completion ?: ^(NSData *data, NSError *error){};
	NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		completion(data, error);
	}];
	[task resume];
}

@end
