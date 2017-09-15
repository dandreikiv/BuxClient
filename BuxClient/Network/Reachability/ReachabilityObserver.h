//
//  ReachabilityObserver.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ReachabilityStatus.h"

@class Reachability;

@protocol ReachabilityObserver <NSObject>

- (void)networkReachabilityStatusChanged:(Reachability *)reachability;

@end
