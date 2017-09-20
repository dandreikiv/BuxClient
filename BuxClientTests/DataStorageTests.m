//
//  DataStorageTests.m
//  BuxClientTests
//
//  Created by dmytro.andreikiv@philips.com on 15/09/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DataStorageProtocol.h"
#import "InMemoryDataStorage.h"
#import "Product.h"

@interface DataStorageTests : XCTestCase

@property (nonatomic, strong) id <DataStorageProtocol> dataStorage;

@end

@implementation DataStorageTests

- (void)setUp {
    [super setUp];
	self.dataStorage = [InMemoryDataStorage new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
	self.dataStorage = nil;
    [super tearDown];
}

- (void)testDataStorageStoresProducts {
	Product *product = [[Product alloc] initWithDictionary:@{@"securityId": @"1"}];
	[self.dataStorage storeProducts:@[product]];
	
	XCTAssertTrue(self.dataStorage.count == 1);
}

- (void)testDataStorageFindProudct {
	Product *product1 = [[Product alloc] initWithDictionary:@{@"securityId": @"1"}];
	Product *product2 = [[Product alloc] initWithDictionary:@{@"securityId": @"2"}];
	[self.dataStorage storeProducts:@[product1, product2]];
	
	Product *product = [self.dataStorage productWithId:@"2"];
	
	XCTAssertEqual(product2, product);
}

- (void)testDataStorageReplacesProducts {
	Product *product1 = [[Product alloc] initWithDictionary:@{@"securityId": @"1"}];
	Product *product2 = [[Product alloc] initWithDictionary:@{@"securityId": @"2"}];
	[self.dataStorage storeProducts:@[product1, product2]];
	
	Product *product3 = [[Product alloc] initWithDictionary:@{@"securityId": @"3"}];
	[self.dataStorage update:product3 withId:@"2"];
	
	XCTAssertNil([self.dataStorage productWithId:@"2"]);
	XCTAssertNotNil([self.dataStorage productWithId:@"3"]);
}


@end
