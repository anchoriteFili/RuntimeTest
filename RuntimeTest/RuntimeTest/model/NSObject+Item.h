//
//  NSObject+Item.h
//  RuntimeTest
//
//  Created by zetafin on 2018/3/15.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

@optional
// 提供一个协议，只要准备这个协议的类，都能把数组中的字典转模型
// 用在三级数组转换
+ (NSDictionary *)arrayCountainModelClass;

@end


@interface NSObject (Item)

// 字典转模型
+ (instancetype)objectWithDict:(NSDictionary *)dict;

@end
