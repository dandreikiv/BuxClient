//
//  ProductListCell.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductListViewModel;

@interface ProductListCell : UITableViewCell

@property (nonatomic, strong) ProductListViewModel *viewModel;

+ (NSString *)identifier;

@end
