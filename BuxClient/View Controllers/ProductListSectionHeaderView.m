//
//  ProductListSectionTitleView.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductListSectionHeaderView.h"

@interface ProductListSectionHeaderView ()

@property (nonatomic, strong) UILabel *title;

@end

@implementation ProductListSectionHeaderView

- (instancetype)init {
	self = [super init];
	if (self) {
		self.title = [UILabel new];
		self.title.font = [UIFont fontWithName:@"AmericanTypewriter" size:14];
		self.title.textColor = [UIColor whiteColor];
		[self addSubview:self.title];
		
		self.title.translatesAutoresizingMaskIntoConstraints = NO;
		[self.title.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:20.0f].active = YES;
		[self.title.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
		[self.title.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
		
		self.backgroundColor = [UIColor colorWithRed:58.0/255.0f green:149.0/255.0 blue:252.0/255.0 alpha:0.5];
	}
	return self;
}

- (void)setTitleText:(NSString *)text {
	self.title.text = text;
}

@end
