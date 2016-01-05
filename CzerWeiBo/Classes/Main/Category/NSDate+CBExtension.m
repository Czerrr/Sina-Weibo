//
//  NSDate+CBExtension.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/7.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "NSDate+CBExtension.h"

@implementation NSDate (CBExtension)
/**
 *  判断是否为今天
 *
 *
 */
- (BOOL)isToday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [NSDate date];
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:nowDate];
    
    return [dateStr isEqualToString:nowStr];
}


/**
 *  判断是否为昨天
 *
 */
- (BOOL)isYesterday {
    // 不能简单的将日期相减，因为存在诸如31号和下个月1号这种情况
    // 处理方法：将时间的小时分钟秒数全部置为0，利用NSDateComponents比较day的差值
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [NSDate date];
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:nowDate];
    
    NSDate *date = [fmt dateFromString:dateStr];
    nowDate = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:date toDate:nowDate options:0];
    return (components.year == 0) && (components.month == 0) && (components.day == 1);
}

/**
 *  判断传入的日期是否为今年
 *
 */
- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:self];
    return (nowComponents.year == dateComponents.year);
}

@end
