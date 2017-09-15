//
//  ReachabilityStatus.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

typedef NS_ENUM(NSInteger, NetworkStatus){
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN
};
