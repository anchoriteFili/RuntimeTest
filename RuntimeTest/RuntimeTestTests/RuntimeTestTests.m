//
//  RuntimeTestTests.m
//  RuntimeTestTests
//
//  Created by 赵宏亚 on 2017/10/13.
//  Copyright © 2017年 赵宏亚. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>

@interface RuntimeTestTests : XCTestCase

@end

@implementation RuntimeTestTests

- (void)testViarList {
    //    1. 初始化一个标记成员变量数的参数
    unsigned int methodCount = 0;
    //    2. copy出类中所有的成员变量，并标记成员变量数
    Ivar *ivars = class_copyIvarList([OneViewController class], &methodCount);
    //    3. 通过for循环遍历出所有成员变量
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        //        4. 获取所有的成员变量名和类型
        const char *type = ivar_getTypeEncoding(ivar);
        const char *name = ivar_getName(ivar);
        NSLog(@"type === %s  name ==== %s",type,name);
    }
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
