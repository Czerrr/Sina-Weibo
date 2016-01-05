//
//  CBEmotionTool.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/14.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

/** 最近表情的存储路径 */
#define CBRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]

#import "CBEmotionTool.h"

@implementation CBEmotionTool

static NSMutableArray *_recentEmotions;

+ (void)initialize {
    // 加载沙盒中的表情数据
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:CBRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [NSMutableArray array];
    }
}

+ (void)addRecentEmotion:(CBEmotion *)emotion {

    
    // 删除重复的表情
    [_recentEmotions removeObject:emotion];
    
    // 将表情插入数组最前面
    [_recentEmotions insertObject:emotion atIndex:0];
    
    // 写入文件
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:CBRecentEmotionsPath];
}

/**
 *  返回装着emotion模型的数组
 *
 */
+ (NSArray *)recentEmotions {
    return _recentEmotions;
}

@end
