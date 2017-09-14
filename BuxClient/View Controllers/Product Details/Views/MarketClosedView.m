//
//  MarketClosedView.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "MarketClosedView.h"
#import "Product.h"

@interface MarketClosedView()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *message;

@end

@implementation MarketClosedView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setupUI];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setupUI];
	}
	return self;
}

- (void)setupUI {
	self.title = [UILabel new];
	self.title.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:24.0];
	self.title.textColor = [UIColor blackColor];
	self.title.textAlignment = NSTextAlignmentCenter;
	[self addSubview:self.title];
	
	self.title.translatesAutoresizingMaskIntoConstraints = NO;
	[self.title.topAnchor constraintEqualToAnchor:self.topAnchor constant:120.0f].active = YES;
	[self.title.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
	
	self.message = [UILabel new];
	self.message.font = [UIFont fontWithName:@"Courier-Bold" size:18.0];
	self.message.textColor = [UIColor blackColor];
	self.message.textAlignment = NSTextAlignmentCenter;
	self.message.text = NSLocalizedString(@"Market is closed", nil);
	[self addSubview:self.message];
	
	self.message.translatesAutoresizingMaskIntoConstraints = NO;
	[self.message.topAnchor constraintEqualToAnchor:self.title.bottomAnchor constant:40.0f].active = YES;
	[self.message.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
}

- (void)setProduct:(Product *)product {
	_product = product;
	self.title.text = product.displayName;
}

@end
