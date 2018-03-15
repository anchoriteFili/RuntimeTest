//
//  SevenViewController.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/13.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "SevenViewController.h"
#import "Movie.h"

@interface SevenViewController ()

@end

@implementation SevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    Movie *m = [Movie new];
    m.movieName = @"aaaaaa";
    m.movieId = @"1222331";
    m.pic_url = @"111111";
    
    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *filePath = [document stringByAppendingString:@"/123.txt"];
    
    NSLog(@"filePath ********* %@",filePath);
    
    // 模型写入文件
    [NSKeyedArchiver archiveRootObject:m toFile:filePath];
    
    // 读取
    Movie *movie = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"---%@",movie);
    
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
