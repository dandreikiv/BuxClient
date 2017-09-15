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
	self.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
	
	self.message = [UILabel new];
	self.message.font = [UIFont fontWithName:@"Courier-Bold" size:18.0];
	self.message.textColor = [UIColor blackColor];
	self.message.textAlignment = NSTextAlignmentCenter;
	self.message.text = NSLocalizedString(@"Market is closed", nil);
	[self addSubview:self.message];
	
	self.message.translatesAutoresizingMaskIntoConstraints = NO;
	[self.message.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
	[self.message.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
}

@end
