//
//  CBAccountTool.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/30.
//  Copyright © 2015年 Czerrr. All rights reserved.
//
// 处理账号相关的所有操作：存储账号、取出账号、验证账号

#import <Foundation/Foundation.h>
#import "CBAccount.h"
@interface CBAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号数据模型
 */
+ (void)saveAccount:(CBAccount *)account;

/**
 *  返回账号模型(如果账号信息过期，返回nil)
 *
 */
+ (CBAccount *)account;
@end
