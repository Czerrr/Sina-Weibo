//
//  CBProfileTableViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/25.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBProfileTableViewController.h"
//#import "UIView+CBExtension.h"
//#import "UIBarButtonItem+CBExtension.h"
#import "CBDropdownMenu.h"
#import "CBSearchBar.h"

@interface CBProfileTableViewController ()

@end

@implementation CBProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 右上角 设置 按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    // 设置按钮不可用
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}



/**
 *  右上角按钮的回调函数
 */
- (void)setting {

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/



@end
