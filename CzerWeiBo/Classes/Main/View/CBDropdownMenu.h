//
//  CBDropdownMenu.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/27.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBDropdownMenu;

@protocol CBDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(CBDropdownMenu *)dropdownMenu;
- (void)dropdownMenuDidShow:(CBDropdownMenu *)dropdownMenu;

@end

// 蒙板和下拉框菜单的工具类
@interface CBDropdownMenu : UIView

+ (instancetype)dropdownMenu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;

/**
 *  销毁
 */
- (void)dismiss;

/**
 *  下拉菜单弹出框里存放的view内容
 */
@property (nonatomic, strong) UIView *content;

/**
 *  下拉菜单弹出框里存放的viewcontroller内容
 */
@property (nonatomic, strong) UIViewController *contentController;

/**
 *  代理
 */
@property (nonatomic, weak) id<CBDropdownMenuDelegate> myDelegate;

@end
