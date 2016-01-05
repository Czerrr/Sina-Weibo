//
//  CBStatusTool.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/17.
//  Copyright © 2015年 Czerrr. All rights reserved.
//  处理微博数据的缓存

#import <Foundation/Foundation.h>

@interface CBStatusTool : NSObject

/**
 *  根据请求参数从沙盒中加载缓存数据
 *
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;

/**
 *  存储数据到数据库中
 *
 */
+ (void)saveStatuses:(NSArray *)statuses;
@end
