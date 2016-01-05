//
//  CBDropdownMenuTableViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/12/25.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBDropdownMenuTableViewController.h"

@interface CBDropdownMenuTableViewController ()
@property (nonatomic, assign) NSInteger selectedCell;
@end

@implementation CBDropdownMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedCell = -1;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const ID = @"DropdownMenu";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
     if (indexPath.row == self.selectedCell) {
        cell.textLabel.textColor = [UIColor orangeColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test data %ld", indexPath.row];
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.selectedCell = indexPath.row;
    cell.textLabel.textColor = [UIColor orangeColor];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blackColor];

}

@end
