//
//  Movie.h
//  RuntimeTest
//
//  Created by zetafin on 2018/3/15.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Item.h"
#import "HGUser.h"

// 如果想要当前类可以实现归档与反归档，需要遵守一个协议NSCoding
@interface Movie : NSObject<NSCoding, ModelDelegate>

@property (nonatomic,strong) HGUser *user;
@property (nonatomic,copy) NSString *movieId;
@property (nonatomic,copy) NSString *movieName;
@property (nonatomic,copy) NSString *pic_url;

@end
