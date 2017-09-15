//
//  ProductDetailsDataCoordinatorOutput.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "WebsocketStatus.h"

@class Product;

@protocol ProductDetailsDataCoordinatorOutput <NSObject>

- (void)updateWithWebSocketStatus:(WebsocketStatus)status;
- (void)updateWithProduct:(Product *)product;

@end
