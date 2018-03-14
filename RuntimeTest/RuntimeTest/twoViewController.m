//
//  twoViewController.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/13.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "twoViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface twoViewController ()

@property (nonatomic,strong) Person *person;
@property (weak, nonatomic) IBOutlet UITextField *textview;

@end

@implementation twoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [Person new];
    
    
}

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


- (IBAction)answer:(UIButton *)sender {
    [self sayFrom];
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
