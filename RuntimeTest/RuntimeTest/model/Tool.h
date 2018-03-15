//
//  Tool.h
//  RuntimeTest
//
//  Created by zetafin on 2018/3/14.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (instancetype)shareManager;

- (NSString *)changeMethod;
- (void)addCount;

@end
