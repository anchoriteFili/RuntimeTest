

> 

```objc

#import "NSObject+Model.h"
#import <objc/runtime.h>

@implementation NSObject (Model)

/**
 可以进一步思考：
 如何识别基本数据类型的属性并处理空（nil,null)值的处理
 json中嵌套json（Dict或Array）的处理
 */

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

```

> 添加有关内容

```objc
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
```

> 字典转模型

```objc
#import "NSObject+Item.h"
#import <objc/message.h>

@implementation NSObject (Item)

// 字典转模型
+ (instancetype)objectWithDict:(NSDictionary *)dict {
    
    // 创建对应模型兑现
    id objc = [[self alloc] init];
    
    unsigned int count = 0;
    
    // 1. 获取成员属性数组
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 2. 遍历所有的成员属性，一个一个去字典中取出对应的value给模型属性赋值
    for (int i = 0; i < count; i ++) {
        
        // 2.1 获取成员属性
        Ivar ivar = ivarList[i];
        
        // 2.2 获取成员属性名 C -> OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 2.3 _成员属性名 => 字典key
        NSString *key = [ivarName substringFromIndex:1];
        
        // 2.4 去字典中取出对应value给模型属性赋值
        id value = dict[key];
        
        
        // 获取成员属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        
        // 二级转换，字典中还有字典，也需要把对应字典转换成模型
        
        // 判断下value，是不是字典
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType containsString:@"NS"]) {
            
            // 是字典对象，并且属性名对应类型时自定义类型
            
            // 处理类型字符串 @\"User\" -> User
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            // 自定义对象，并且值是字典
            // value:user字典 -> User模型
            // 获取模型(user)类对象
            Class modalClass = NSClassFromString(ivarType);
            
            
            // 字典转模型
            if (modalClass) {
                // 字典转模型 user
                value = [modalClass objectWithDict:value];
            }
            
            // 字典，user
            // NSLog(@"%@", key);
        }
        
        // 三级转换：NSArray中也是字典，把数组中的字典转换成模型。
        // 判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(arrayCountainModelClass)]) {
                
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                
                // 获取数组中字典的模型
                NSString *type = [idSelf arrayCountainModelClass][key];
                
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    // 字典转模型
                    id model = [classModel objectWithDict:dict];
                    [arrM addObject:model];
                }
                
                // 把模型数组赋值给value
                value = arrM;
            }
        }
        
        // 2.5 KVC字典转模型
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    // 返回对象
    return objc;
}

@end
```

```objc

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
```

> 使用storyBoard进行页面push

```objc

    // 1. 获取storyBoard（Main固定，是sb的名字）
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    // 从storyBoard中获取控制器
    oneViewController *oneVC = (oneViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"onevciden"];
    [self.navigationController pushViewController:oneVC animated:YES];

```

```objc
- (void)sayName {
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.person class], &count);
    
    for (int i = 0; i < count; i ++) {
        Ivar var = ivar[i];
        
        const char *varName = ivar_getName(var);
        
        NSString *proname = [NSString stringWithUTF8String:varName];
        
        if ([proname isEqualToString:@"_name"]) {
            object_setIvar(self.person, var, @"daming");
            break;
        }
    }
    
    NSLog(@"XiaoMing change name is %@",self.person.name);
    self.textfield.text = self.self.person.name;
}
```

> 添加方法

```objc
- (void)sayFrom {
    
    class_addMethod([self.person class], @selector(guess), (IMP)guessAnswer, "v@:");
    
    if ([self.person respondsToSelector:@selector(guess)]) {
        [self.person performSelector:@selector(guess)];
    } else {
        NSLog(@"Sorry, I don`t know");
    }
    self.textview.text = @"beijing";
}

void guessAnswer(id self,SEL _cmd) {
    NSLog(@"I am frome bejing");
}
```

> 方法的替换

```objc
Method m1 = class_getInstanceMethod([self.person class], @selector(sayName));
Method m2 = class_getInstanceMethod([self.person class], @selector(saySex));
method_exchangeImplementations(m1, m2);

- (IBAction)sayName:(UIButton *)sender {
    
    self.textview.text = [_person sayName];
}


- (IBAction)saySex:(UIButton *)sender {
    
    self.textview.text = [_person saySex];
}
```

```objc
Method m1 = class_getInstanceMethod([Person class], @selector(sayName));
Method m2 = class_getInstanceMethod([Tool class], @selector(changeMethod));
method_exchangeImplementations(m1, m2);
```




