//
//  NSObject+Model.m
//  RuntimeTest
//
//  Created by 赵宏亚 on 2017/10/13.
//  Copyright © 2017年 赵宏亚. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [self init]) {
//        1. 获取类的属性即属性对应的类型
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *attributes = [NSMutableArray array];
        
        unsigned int outCount;
//        2. 获取属性列表
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        
        for (int i = 0; i < outCount; i ++) {
            // 遍历出单一属性
            objc_property_t property = properties[i];
            // 获取属性名
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            // 将所有的属性名放到key中
            [keys addObject:propertyName];
            // 通过property_getAttributes函数可以获得属性的名字和@endcode编码
            NSString *propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            
            // 将属性放入到属性数组中
            [attributes addObject:propertyAttribute];
        }
        // 立即释放properties指向的内存
        free(properties);
        
        // 根据类型给属性赋值
        for (NSString *key in keys) {
            if ([dict valueForKey:key] == nil) {
                continue;
            } else {
                [self setValue:[dict valueForKey:key] forKey:key];
            }
        }
    }
    return self;
    
}

@end
