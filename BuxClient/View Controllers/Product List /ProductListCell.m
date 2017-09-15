//
//  ProductListCell.m
//  BuxClient
//
//  Created by dmytro.andreikiv@philips.com on 14/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import "ProductListCell.h"
#import "ProductListViewModel.h"

@interface ProductListCell()

@property (nonatomic, strong) UILabel *productName;

@end;

@implementation ProductListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self setupUI];
	}
	return self;
}

- (void)setupUI {
	self.productName = [UILabel new];
	self.productName.backgroundColor = [UIColor clearColor];
	self.productName.textColor = [UIColor blackColor];
	self.productName.textAlignment = NSTextAlignmentCenter;
	self.productName.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:20];
	
	[self.contentView addSubview:self.productName];
	self.productName.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.productName.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
	[self.productName.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
	[self.productName.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
	[self.productName.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
}

- (void)setViewModel:(ProductListViewModel *)viewModel {
	self.productName.text = viewModel.displayName;
}

+ (NSString *)identifier {
	static dispatch_once_t onceToken;
	static NSString *identifier;
	dispatch_once(&onceToken, ^{
		identifier = NSStringFromClass([self class]);
	});
	return identifier;
}

@end
