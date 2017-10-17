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

/**
 Object-C语言是一门动态语言，它将很多静态语言在编译和链接时期做的事放到了运行时来处理。
 这种动态语言的优势在于：我们写代码时更具灵活性，如我们可以吧消息转发给我们想要的对象，
 或者随意交换一个方法的实现等。
 Object-C类是由Class类型来表示的，它实际上是一个指向objc_class结构体的指针。
 */

- (void)testClass {
    /**
     参数1：父类
     参数2：子类名
     参数3：extraBytes
     */
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0); // 创建新的类名
    
    
    /**
     参数1：类名
     参数2：方法名称
     参数3：方法（IMP）你写的方法名
     参数4：一个定义该函数返回值类型和参数类型的字符串，根据返回值和参数动态的确定
     查看返回值类型表达方法
     这里可以查看对应返回值类型的表达方法v表示void后边的:后边表示参数 比如说 定义
     int:(id self, SEL _cmd, NSString *name)那么就是i@:@这样的。
     */
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    
    objc_registerClassPair(newClass); // 注册创建的类
    
    // 实例化对象
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    
    [instance performSelector:@selector(testMetaClass)]; // 调用方法
    
    /**
     // 获取类的名称
     const char * class_getName( Class cls );
     
     // 获取类的父类
     Class class_getSuperclass( Class cls );
     
     // 判断给定的Class是否是一个元类
     BOOL class_isMetaClass ( Class cls );
     
     // 获取实例大小
     size_t class_getInstanceSize ( Class cls );
     
     在objc_class中，所有的成员变量、属性的信息都放在链表ivars中。ivars是一个
     class_copyIvarList的函数，它返回一个指向成员变量信息的数组，数组中每个元素是
     是指向该成员变量信息的objc_ivar结构体的指针。这个数组不包含在父类中声明的变量。
     outCount指针返回数组的大小。需要注意的是，我们必须使用free()来释放这个数组。
     
     // 获取类中指定名称实例成员变量的信息
     Ivar class_gatInstanceVariable ( Class cls, const char *name );
     
     // 获取类成员变量的信息
     Ivar class_getClassVariable ( Class cls, const char *name);
     
     // 添加成员变量
     BOOL class_addIvar ( Class cls, const char *name,size_t size,
     uint8_t alignment, const char *types );
     
     // 获取整个成员变量列表
     Ivar * class_copyIvarList ( Class cls, unsigned int *outCount );
     
     // 获取指定的属性
     objc_porperty_t class_getProperty ( Class cls, const char *name );
     
     // 获取属性列表
     objc_property_t * class_copyPropertyList ( Class cls, unsigned int *outCount );
     
     // 为类添加属性
     BOOL class_addproperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
     
     // 替换类的属性
     void class_replaceProperty ( Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount );
     
     // 添加方法
     BOOL class_addMethod ( Class cls, SEL name, IMP imp, const char *types );
     
     // 获取实例方法
     Method class_getInstanceMethod ( Class cls, SEL name );
     
     // 获取所有方法的数组
     Method * class_copyMethodList ( Class cls, unsigned int *outCount );
     
     // 替代方法的实现
     IMP class_replaceMethod ( Class cls, SEL name, IMP imp, const char *types );
     
     // 返回方法的具体实现
     
     
     
     
     */
    
    // 获取类的类名
    
    
}

- (void)testMetaClass {
    NSLog(@"哈哈哈哈");
}


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
    
//    NSDictionary *dic = @{@"name":@"张三"};
//    Model *model = [[Model alloc] init];
//    [model initWithDict:dic];
//
//    NSLog(@"name ======= %@",model.name);
    
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
