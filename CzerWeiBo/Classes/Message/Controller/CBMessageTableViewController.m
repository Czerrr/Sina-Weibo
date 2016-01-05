//
//  CBMessageTableViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/25.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBMessageTableViewController.h"
#import "CBTest1ViewController.h"

@interface CBMessageTableViewController ()

@end

@implementation CBMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加右上角 barbuttonitem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMessage)];
}

- (void)composeMessage {
    UIViewController *viewVC = [[UIViewController alloc] init];
    viewVC.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:viewVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-messsage-%ld", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBTest1ViewController *test1 = [[CBTest1ViewController alloc] init];
    test1.title = @"test1";
    [self.navigationController pushViewController:test1 animated:YES];
}



@end
