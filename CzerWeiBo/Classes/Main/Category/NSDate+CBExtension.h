//
//  NSDate+CBExtension.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/7.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CBExtension)
/**
 *  判断是否为今天
 *
 *
 */
- (BOOL)isToday;


/**
 *  判断是否为昨天
 *
 */
- (BOOL)isYesterday;

/**
 *  判断传入的日期是否为今年
 *
 */
- (BOOL)isThisYear;

@end
