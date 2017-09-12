//
//  ProductsViewController.h
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 11/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InteractorOutput.h"

@protocol InteractorInput;

@interface ProductsViewController : UIViewController <InteractorOutput>

@property (nonatomic, strong) id <InteractorInput> interactor;

@end

