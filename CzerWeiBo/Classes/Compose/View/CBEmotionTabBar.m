//
//  CBEmotionTabBar.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/10.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionTabBar.h"
#import "CBComposeTabBarButton.h"

@interface CBEmotionTabBar ()
@property (nonatomic, weak) CBComposeTabBarButton *selectedButton;
@end

@implementation CBEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" image:[UIImage imageNamed:@"compose_emotion_table_left_normal"] highImage:[UIImage imageNamed:@"compose_emotion_table_left_selected"] buttonType:CBEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" image:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] highImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] buttonType:CBEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" image:[UIImage imageNamed:@"compose_emotion_table_mid_normal"] highImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] buttonType:CBEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" image:[UIImage imageNamed:@"compose_emotion_table_right_normal"] highImage:[UIImage imageNamed:@"compose_emotion_table_right_selected"] buttonType:CBEmotionTabBarButtonTypeLxh];

    }
    return self;
}

/**
 *  创建一个按钮
 *
 */
- (CBComposeTabBarButton *)setupBtn:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage buttonType:(CBEmotionTabBarButtonType)buttonType {
    CBComposeTabBarButton *btn = [[CBComposeTabBarButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];

    
    // 设置背景图片
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateDisabled];
    
    // 设置buttonType
    btn.tag = buttonType;
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    return btn;
}

- (void)setDelegate:(id<CBEmotionTabBarDelegate>)delegate {
    _delegate = delegate;
    
    // 选中“默认”按钮 在代理存在之后才会通知代理
    [self btnClick:[self viewWithTag:CBEmotionTabBarButtonTypeDefault]];
}


/**
 *  监听按钮点击
 *
 */
- (void)btnClick:(CBComposeTabBarButton *)btn {
    self.selectedButton.enabled = YES;
    btn.enabled = NO;
    self.selectedButton = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(CBEmotionTabBarButtonType)btn.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < btnCount; i++) {
        CBComposeTabBarButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
}

@end
