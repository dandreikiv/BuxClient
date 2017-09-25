//
//  RealmProduct.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 25/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RealmProduct : RLMObject

@property NSString *productId;
@property NSString *displayName;

@end
