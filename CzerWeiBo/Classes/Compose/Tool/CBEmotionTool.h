//
//  CBEmotionTool.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/14.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBEmotion;
@interface CBEmotionTool : NSObject
+ (void)addRecentEmotion:(CBEmotion *)emotion;
+ (NSArray *)recentEmotions;
@end
