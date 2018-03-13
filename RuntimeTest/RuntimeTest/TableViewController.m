//
//  TableViewController.m
//  RuntimeTest
//
//  Created by zetafin on 2018/3/13.
//  Copyright © 2018年 赵宏亚. All rights reserved.
//

#import "TableViewController.h"
#import "oneViewController.h"

@interface TableViewController ()

@property (nonatomic,strong) NSArray *dataSource; // 存储行数据

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"runtime";
    
    /**
     1. 动态变量控制
     2. 动态添加方法
     3. 动态交换两个方法的实现
     4. 拦截并替换方法
     5. 在方法上添加额外功能
     6. 实现NSCoding的自动归档和解档
     7. 实现字典转模型的自动转换
     */

    
    _dataSource = @[@"动态变量控制",
                    @"动态添加方法",
                    @"动态交换两个方法的实现",
                    @"拦截并替换方法",
                    @"在方法上添加额外功能",
                    @"实现NSCoding的自动归档和解档",
                    @"实现字典转模型的自动转换"];
    
    self.tableView.tableFooterView = [UIView new];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    // 2. 判断是否有可重用的，如果没有，则自己创建
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 获取storyBoard（Main固定，是sb的名字）
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSInteger index = indexPath.row;
    
    switch (index) {
        case 0: {
            // 从storyBoard中获取控制器
            oneViewController *oneVC = (oneViewController *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"onevciden"];
            [self.navigationController pushViewController:oneVC animated:YES];
            break;
        }
            
            
        case 1: {
            
            break;
        }
            
        case 2: {
            
            break;
        }
            
        case 3: {
            
            break;
        }
            
        case 4: {
            
            break;
        }
            
        case 5: {
            
            break;
        }
            
        case 6: {
            
            break;
        }
            
        default:
            break;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
