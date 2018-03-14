//
//  oneViewController.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/13.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "oneViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface oneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (nonatomic,strong) Person *person;

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [Person new];
    _person.name = @"xiaoming";
    NSLog(@"XiaoMing first answer is %@",self.person.name);
    
}

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



- (IBAction)changename:(id)sender {
    [self sayName];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
