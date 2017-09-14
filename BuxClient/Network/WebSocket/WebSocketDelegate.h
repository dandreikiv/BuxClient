//
//  WebSocketDelegate.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

@protocol WebSocketDelegate <NSObject>

- (void)didGetQuoteAmount:(NSNumber *)amount forProductWithId:(NSString *)productId;

@end
