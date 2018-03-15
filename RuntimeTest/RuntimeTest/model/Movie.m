//
//  Movie.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/15.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "Movie.h"
#import <objc/runtime.h>

@implementation Movie


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([Movie class], &count);
    
    for (int i = 0; i < count; i ++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Movie class], &count);
        
        for (int i = 0; i < count; i ++) {
            // 取出i位置对应的成员变量。
            Ivar ivar = ivars[i];
            
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@--%@--%@--%@", _movieName, _movieId, _pic_url, _user];
}



@end
