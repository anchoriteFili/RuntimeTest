//
//  Tool.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/14.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "Tool.h"

@interface Tool ()

@property (nonatomic, assign) NSInteger count;

@end

@implementation Tool

+ (instancetype)shareManager {
    static Tool *_sInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sInstance = [[Tool alloc] init];
    });
    
    return _sInstance;
}

- (NSString *)changeMethod {
    return @"haha, 你的方法被替换掉了";
}

- (void)addCount {
    _count += 1;
    NSLog(@"点击次数 ------ %ld",_count);
}

@end
