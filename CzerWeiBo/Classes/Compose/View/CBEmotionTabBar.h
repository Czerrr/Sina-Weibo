//
//  CBEmotionTabBar.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/10.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 表情键盘底部选项卡
#import <UIKit/UIKit.h>

typedef enum {
    CBEmotionTabBarButtonTypeRecent,
    CBEmotionTabBarButtonTypeDefault,
    CBEmotionTabBarButtonTypeEmoji,
    CBEmotionTabBarButtonTypeLxh
} CBEmotionTabBarButtonType;

@class CBEmotionTabBar;

@protocol CBEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(CBEmotionTabBar *)tabBar didSelectButton:(CBEmotionTabBarButtonType)buttonType;
@end

@interface CBEmotionTabBar : UIView
@property (nonatomic, weak) id<CBEmotionTabBarDelegate> delegate;

@end
