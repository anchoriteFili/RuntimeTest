//
//  RuntimeTestTests.m
//  RuntimeTestTests
//
//  Created by 赵宏亚 on 2017/10/13.
//  Copyright © 2017年 赵宏亚. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "OneViewController.h"
#import "NSObject+Model.h"
#import "Model.h"

@interface RuntimeTestTests : XCTestCase

@end

@implementation RuntimeTestTests


// 测试ivar相关
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

/**  属性
 1. 属性的定义
 objc_property_t : 声明的属性的类型，是一个指向objc_property结构体的指针
 typedef strunt objc_property *objc_property_t;
 
 2. 相关函数
     // 获取所有属性
     class_copyPropertyList
     说明：使用class_copyPropertyList并不会获取无@property声明的成员变量
     // 获取属性名
     property_getName
     // 获取属性特性描述字符串
     property_getAttributes
     // 获取所有属性特性
     property_copyAttributeList
 */

- (void)testProperty {
//    1. 获取属性变量数量
    unsigned int propertyCount = 0;
//    2. 获取属性变量列表
    objc_property_t *propertyList = class_copyPropertyList([OneViewController class], &propertyCount);
//    3. 遍历属性变量列表
    for (unsigned int i = 0; i < propertyCount; i ++) {
        objc_property_t *thisProperty = &propertyList[i];
//        4. 获取属性名
        const char *propertyName = property_getName(*thisProperty);
        const char *attribute = property_getAttributes(*thisProperty);
        // 打印出属性名
        NSLog(@"propertyName ==== %s attribute ==== %s",propertyName,attribute);
    }
}

- (void)testPropertyOne {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([OneViewController class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        objc_property_t *thisProperty = &propertyList[i];
        const char *propertyName = property_getName(*thisProperty);
        const char *attr = property_getAttributes(*thisProperty);
        
        NSLog(@"propertyName ==== %s  attr ==== %s",propertyName,attr);
    }
}

/**
 应用场景
 1. json到Model的转化
 在开发中相信最常用的就是接口数据转化为Model了（当然你是直接从dic中取值的话），很多开发者
 也都使用注明的第三方库如JsonModel、Mantle或MJExtension等，如果只用而不知其所以然那真
 和搬砖没什么区别了，下面我们使用runtime去解析json来给Model赋值。
 原理描述：用runtime提供的函数遍历Model自身所有属性，如果属性在json中有对应的值，则将其赋值。
 核心方法：在NSObject的分类中添加方法
 */

- (void)testDict {
    
    NSDictionary *dic = @{@"name":@"张三"};
    Model *model = [[Model alloc] init];
    [model initWithDict:dic];
    
    NSLog(@"name ======= %@",model.name);
    
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
