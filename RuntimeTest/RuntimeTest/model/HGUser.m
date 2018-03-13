//
//  HGUser.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/13.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "HGUser.h"

@implementation HGUser

- (NSString *)description {
    return [NSString stringWithFormat:@"%@--%@--%@--",_name, _age, _sex];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    }
}

@end
