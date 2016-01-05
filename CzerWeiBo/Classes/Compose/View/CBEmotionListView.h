//
//  CBEmotionListView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/10.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 表情键盘顶部的表情内容列表 scrollView + pageControl
#import <UIKit/UIKit.h>

@interface CBEmotionListView : UIView
/** 表情(里面存放的是CBEmotion模型) */
@property (nonatomic, strong) NSArray *emotions;

@end
