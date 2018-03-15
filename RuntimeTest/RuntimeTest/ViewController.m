///Users/zetafin/赵宏亚/git/RuntimeTest/RuntimeTest/RuntimeTest/oneViewController.m
//  ViewController.m
//  RuntimeTest
//
//  Created by 赵宏亚 on 2017/10/13.
//  Copyright © 2017年 赵宏亚. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

#pragma 点击进入tableview
- (IBAction)click:(UIButton *)sender {
    
    TableViewController *tabvc = [TableViewController new];
    [self.navigationController pushViewController:tabvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
