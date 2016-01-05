//
//  CBTabBarController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/25.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBTabBarController.h"
#import "CBHomeTableViewController.h"
#import "CBMessageTableViewController.h"
#import "CBDiscoverTableViewController.h"
#import "CBProfileTableViewController.h"
#import "CBNavigationController.h"
#import "CBTabBar.h"
#import "CBComposeViewController.h"

@interface CBTabBarController () <CBTabBarDelegate>

@end

@implementation CBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    // 给tabbar添加子控制器
    // home
    CBHomeTableViewController *homeVC = [[CBHomeTableViewController alloc] init];
//    homeVC.view.backgroundColor = [UIColor greenColor];
    [self addChildVC:homeVC image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"] title:@"首页"];
    
    // message
    CBMessageTableViewController *messageVC = [[CBMessageTableViewController alloc] init];
//    messageVC.view.backgroundColor = [UIColor redColor];
    [self addChildVC:messageVC image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] title:@"消息"];
    
    // discover
    CBDiscoverTableViewController *discoverVC = [[CBDiscoverTableViewController alloc] init];
//    discoverVC.view.backgroundColor = [UIColor blueColor];
    [self addChildVC:discoverVC image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] title:@"发现"];
    
    // profile
    CBProfileTableViewController *profileVC = [[CBProfileTableViewController alloc] init];
//    profileVC.view.backgroundColor = [UIColor purpleColor];
    [self addChildVC:profileVC image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] title:@"我"];
    
    
    // 更换系统自带的TabBar
    CBTabBar *tabBar = [[CBTabBar alloc] init];
    tabBar.myDelegate = self;
    
    // 相当于self.tabBar = tabBar 修改readonly
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

/**
 *  创建 添加tabbar的子控制器
 *
 */
- (void)addChildVC:(UIViewController *)childVC image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title  {
//    childVC.tabBarItem.title = title;
//    childVC.navigationItem.title = title;
    childVC.title = title;
    
    // 设置选中下文字颜色为橙色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateSelected];
    
    childVC.tabBarItem.image = image;
    childVC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 将子控制器添加到navigation控制器中
    CBNavigationController *nav = [[CBNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}



#pragma mark - 实现tabbar的代理方法
- (void)tabBarDidClickPlusButton:(CBTabBar *)tabBar {
    
    CBComposeViewController *compose = [[CBComposeViewController alloc] init];
    
    CBNavigationController *nav = [[CBNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
