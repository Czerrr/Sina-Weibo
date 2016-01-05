//
//  AppDelegate.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/25.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "AppDelegate.h"
#import "CBOAuthViewController.h"
#import "CBAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 2.设置window根控制器
    
    // 归档取得账号信息
    CBAccount *account = [CBAccountTool account];
    
    if (account) {     // 之前已经登录过
        // 窗口的根控制器
        [self.window switchRootViewController];
    } else {
        self.window.rootViewController = [[CBOAuthViewController alloc] init];
    }

    // 3.显示window
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

/**
 *  当app进入后台时调用
 *
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    /**
     *  app状态
     *  1.没有打开状态
     *  2.前台运行状态
     *  3.后台暂停状态
     *  4.后台运行状态
     */
    
    // 向操作系统申请后台运行的资格，能维持多久是不确定的
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        // 当申请的后台运行时间已经过期，就会调用这个block
        
        // 赶紧结束任务
        [application endBackgroundTask:task];
    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  内存警告的时候做处理
 *
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    // 1. 取消下载
    [manager cancelAll];
    
    // 2. 清除内存中的所有图片
    [manager.imageCache clearMemory];
}

@end
