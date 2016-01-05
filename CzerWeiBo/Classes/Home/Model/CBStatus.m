//
//  CBStatus.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/31.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBStatus.h"
#import "CBUser.h"
#import "CBPhoto.h"
#import "RegexKitLite.h"
/**
 *  微博模型
 */
@implementation CBStatus

/**
 *  重写setText方法，在这里将普通内容转换为带属性的内容
 *
 */
- (void)setText:(NSString *)text {
    _text = [text copy];
    
    self.attributedText = [self attributedTextWithText:text];
}

- (void)setRetweeted_status:(CBStatus *)retweeted_status {
    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@", retweeted_status.user.name, retweeted_status.text];
    
    self.retweetedAttributedText = [self attributedTextWithText:retweetContent];
}

/**
 *  普通文字转成属性文字
 *
 *
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text {
    // 利用text生成attrText
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
    
    // 正则表达式规则
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:*capturedRanges];
    }];
    return attrStr;
}

+ (instancetype)statusWithDict:(NSDictionary *)dict {
    // 1.除转发微博属性外其他属性的字典转模型
    CBStatus *status = [CBStatus noneRetweetStatusWithDict:dict];

    // 2.转发微博属性的字典转模型
    if (dict[@"retweeted_status"]) {
        status.retweeted_status = [self noneRetweetStatusWithDict:dict[@"retweeted_status"]];
    }
    return status;
}

/**
 *  一般微博（转发微博属性为nil）字典转模型
 *
 */
+ (instancetype)noneRetweetStatusWithDict:(NSDictionary *)dict {
    CBStatus *status = [[CBStatus alloc] init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [CBUser userWithDict:dict[@"user"]];
    status.created_at = dict[@"created_at"];
    status.source = dict[@"source"];
    status.pic_urls = [self photoArrayWithDictArray:dict[@"pic_urls"]];
    status.reposts_count = [dict[@"reposts_count"] intValue];
    status.comments_count = [dict[@"comments_count"] intValue];
    status.attitudes_count = [dict[@"attitudes_count"] intValue];
    
    return status;
}


/**
 *  微博配图字典数组转模型数组
 */
+ (NSArray *)photoArrayWithDictArray:(NSArray *)array {
    NSMutableArray *photoArray = [NSMutableArray array];
    for (NSDictionary *photoDict in array) {
        CBPhoto *photo = [CBPhoto photoWithDict:photoDict];
        [photoArray addObject:photo];
    }
    return photoArray;
}

/**
 *  重写获取时间的get方法，不用set方法因为时间需要不断更新，set方法只会调用一次
 *
 */
/**
 1.今年
 1）今天
 // 刚刚 1分钟内
 
 // xx分钟前 1~59分钟内
 
 // xx小时前 大于60分钟
 
 2）昨天
 // 昨天 xx:xx
 
 3）其它天
 // xx-xx xx:xx
 
 2.非今年
 xxxx-xx-xx xx:xx
 */
-(NSString *)created_at {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 如果是真机调试，转换这种欧美时间需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期的格式，声明字符串里每个数字和单词的含义
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";

    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象 方便比较两个日期之间的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *components = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    
    // 逻辑判断
    if ([createDate isThisYear]) {
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (components.hour >= 1) { //大于1小时
                return [NSString stringWithFormat:@"%ld小时前", components.hour];
            } else if (components.minute >= 1) { // 1小时内，大于1分钟
                return [NSString stringWithFormat:@"%ld分钟前", components.minute];
            } else { // 1分钟内
                return @"刚刚";
            }
        } else { // 其它天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
}


/**
 *  重写来源的set方法，只会调用一次，所以不用重写get方法
 *
 */
- (void)setSource:(NSString *)source {
    if (source.length) {
        NSRange range;
        
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
    }
}

@end



