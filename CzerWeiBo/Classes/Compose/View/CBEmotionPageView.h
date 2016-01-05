//
//  CBEmotionPageView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/12.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 用来表示scrollView上一页的表情（代表1～20个）
#import <UIKit/UIKit.h>

// 一页最多几列
#define CBEmotionMaxCols 7
// 一页最多几行
#define CBEmotionMaxRows 3

// 每一页的表情个数
#define CBEmotionPageSize ((CBEmotionMaxCols * CBEmotionMaxRows) - 1)

@interface CBEmotionPageView : UIView
/** 表情（里面存放CBEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;

@end
