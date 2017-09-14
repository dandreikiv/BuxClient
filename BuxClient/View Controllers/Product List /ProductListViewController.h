//
//  ViewController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCoordinatorOutput.h"

@class DataCoordinator;

@interface ProductListViewController : UIViewController <DataCoordinatorProductListOutput>

@property (nonatomic, strong) DataCoordinator *dataCoordinator;

@end

