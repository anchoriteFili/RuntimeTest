//
//  UIButton+count.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/15.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "UIButton+count.h"
#import "Tool.h"
@implementation UIButton (count)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = [self class];
        
        SEL oriSEL = @selector(sendAction:to:forEvent:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(mySendAction:to:forEvent:);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        // 添加方法
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            // 如果添加方法成功，则进行方法替换
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            //
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [[Tool shareManager] addCount];
    [self mySendAction:action to:target forEvent:event];
}

@end
