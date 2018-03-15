//
//  SixViewController.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/13.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "SixViewController.h"
#import "Movie.h"

@interface SixViewController ()
@property (nonatomic, retain) NSMutableArray *allDataArray;
@end

@implementation SixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.allDataArray = [NSMutableArray array];
    
    NSDictionary *user = @{ @"name" : @"zhangsan",
                            @"age" : @(12),
                            @"sex" : @"man",
                            };
    
    NSDictionary *dict = @{ @"movieId" : @"28678",
                            @"movieName" : @"539fU8276",
                            @"pic_url" : @"fsdfds",
                            @"user" : user
                            };
    
    NSArray *addarr = @[dict, dict, dict];
    
    NSMutableDictionary *mudict = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    [mudict setObject:user forKey:@"user"];
    
    for (NSDictionary *item in addarr) {
        Movie *movie = [Movie objectWithDict:item];
        [self.allDataArray addObject:movie];
    }
    
    NSLog(@"---- %@",_allDataArray);
    
    
    
    
    // Do any additional setup after loading the view.
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
