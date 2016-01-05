//
//  UIWindow+CBExtension.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/30.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "UIWindow+CBExtension.h"
#import "CBTabBarController.h"
#import "CBNewFeatureViewController.h"

@implementation UIWindow (CBExtension)
- (void)switchRootViewController {
    //切换窗口的根控制器，根据版本号设置是否需要显示newFeature
    NSString *key = @"CFBundleVersion";
    // 上一次使用的版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[CBTabBarController alloc] init];
    } else {
        self.rootViewController = [[CBNewFeatureViewController alloc] init];
        // 将当前版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
@end
