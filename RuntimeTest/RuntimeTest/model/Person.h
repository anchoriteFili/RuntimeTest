//
//  Person.h
//  RuntimeTest
//
//  Created by zetafin on 2018/3/13.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *sex;

- (NSString *)sayName;
- (NSString *)saySex;


@end
