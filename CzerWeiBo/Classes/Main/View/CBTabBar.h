//
//  CBTabBar.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/28.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBTabBar;

@protocol CBTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(CBTabBar *)tabBar;
@end

@interface CBTabBar : UITabBar
@property (nonatomic, weak) id<CBTabBarDelegate> myDelegate;

@end
