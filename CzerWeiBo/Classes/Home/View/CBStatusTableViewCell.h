//
//  CBStatusTableViewCell.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/3.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBStatusFrame;

@interface CBStatusTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CBStatusFrame *statusFrame;
@end
