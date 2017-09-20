//
//  NetworkManager.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

/**
 The only purpose of the method is to perform network operation with given request.
 It gets data as operation result and returns it via completion handler in raw format
 without any processing.

 @param request a request which should be performed.
 @param completion a block which invokes when a network task is completed or failed.
 */
- (void)performRequest:(NSURLRequest *)request
			completion:(void (^)(NSData *, NSError *))completion;

@end
