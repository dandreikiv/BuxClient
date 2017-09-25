//
//  RealmPerson.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 25/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "RealmProduct.h"

@implementation RealmProduct

+ (NSString *)primaryKey {
	return @"productId";
}

+ (NSDictionary *)defaultPropertyValues {
	return @{ @"displayName": @(0.0) };
}

@end
