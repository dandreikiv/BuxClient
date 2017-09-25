//
//  DataBaseStorageTests.m
//  BuxClientTests
//
//  Created by dmytro.andreikiv@philips.com on 25/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataStorageProtocol.h"
#import "DataBaseStorage.h"
#import "Product.h"
#import <Realm/Realm.h>

static NSString *const kDisplayName = @"displayName";
static NSString *const kCurrentPrice = @"currentPrice";
static NSString *const kClosingPrice = @"closingPrice";
static NSString *const kProductId = @"securityId";

@interface DataBaseStorageTests : XCTestCase

@property (nonatomic, strong) DataBaseStorage *dataStorage;

@end

@implementation DataBaseStorageTests

- (void)setUp {
    [super setUp];
	self.dataStorage = [[DataBaseStorage alloc] init];
	
	[self.dataStorage cleanStorage];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStorageStoresObjects {
	NSDictionary *productDictionary = @{kProductId : @"1", kDisplayName: @"Product"};
	Product *product = [[Product alloc] initWithDictionary:productDictionary];
	[self.dataStorage storeProduct:product];
	XCTAssertTrue(self.dataStorage.count == 1);
}

- (void)testStorageRemovesObjectWithId {
	NSDictionary *productDictionary = @{kProductId : @"1", kDisplayName: @"Product"};
	Product *product = [[Product alloc] initWithDictionary:productDictionary];
	[self.dataStorage storeProduct:product];
	XCTAssertTrue(self.dataStorage.count == 1);
	
	[self.dataStorage removeProductWithId:product.productId];
	XCTAssertTrue(self.dataStorage.count == 0);
}

@end
