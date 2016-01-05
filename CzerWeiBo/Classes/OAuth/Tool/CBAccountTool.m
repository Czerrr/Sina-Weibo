//
//  CBAccountTool.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/30.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 账号的存储路径
#define CBAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "CBAccountTool.h"
#import "CBAccount.h"

@implementation CBAccountTool


/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(CBAccount *)account {
    
    // 自定义对象的存储必须用NSKeyedArchiver，不能用writeToFile(字典数组等才能用)
    [NSKeyedArchiver archiveRootObject:account toFile:CBAccountPath];
}

/**
 *  返回账号数据模型(过期返回nil)
 *
 */
+ (CBAccount *)account {
    
    // 加载模型
    CBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CBAccountPath];
    
    // 验证账号是否过期
    
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    
    // 获得过期时间
    NSDate *expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    
    // 获取当前时间
    NSDate *now = [NSDate date];

    // now >= expiresTime 代表过期
    NSComparisonResult result = [expiresTime compare:now];
    
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end



