//
//  CBDiscoverTableViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/25.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBDiscoverTableViewController.h"
#import "CBSearchBar.h"

@interface CBDiscoverTableViewController ()

@end

@implementation CBDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

/*
    // 设置顶部的搜索框 用取代
    UITextField *searchBar = [[UITextField alloc] init];
    searchBar.width = 300;
    searchBar.height = 30;
    searchBar.placeholder = @"Please enter...";

    
    // 这里图片在xcode里设置了拉升slicing属性
    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    
    // 给searchBar添加放大镜图片
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.width = 30;
    searchIcon.height = 30;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    // 添加searchIcon到searchBar上
    searchBar.leftView = searchIcon;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
*/
    
    // 将上述代码封装成工具类CBSearchBar
    CBSearchBar *searchBar = [CBSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    
    // 添加searchBar到navigationItem上面
    self.navigationItem.titleView = searchBar;
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
