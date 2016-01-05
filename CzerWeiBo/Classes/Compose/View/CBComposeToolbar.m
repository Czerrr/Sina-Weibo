//
//  CBComposeToolbar.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/9.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBComposeToolbar.h"

@interface CBComposeToolbar ()
/** 表情按钮（用于键盘切换时更换图标） */
@property (nonatomic, weak) UIButton *emotionButton;
@end

@implementation CBComposeToolbar

/**
 *  是否是自定义的表情键盘
 *
 */
- (void)setIsEmotionKeyboard:(BOOL)isEmotionKeyboard {
    if (isEmotionKeyboard) { // 使用自定义的表情键盘
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];

    } else {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        // 初始化按钮
        [self setupButton:[UIImage imageNamed:@"compose_camerabutton_background"] highImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] type:CBComposeToolbarButtonTypeCamera];
        [self setupButton:[UIImage imageNamed:@"compose_toolbar_picture"] highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] type:CBComposeToolbarButtonTypePicture];
        [self setupButton:[UIImage imageNamed:@"compose_mentionbutton_background"] highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] type:CBComposeToolbarButtonTypeMention];
        [self setupButton:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] type:CBComposeToolbarButtonTypeTrend];
         self.emotionButton = [self setupButton:[UIImage imageNamed:@"compose_emoticonbutton_background"] highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] type:CBComposeToolbarButtonTypeEmotion];
        
    }
    return self;
}

/**
 *  创建一个按钮
 *
 */
- (UIButton *)setupButton:(UIImage *)image highImage:(UIImage *)highImage type:(CBComposeToolbarButtonType)type {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:(CBComposeToolbarButtonType)btn.tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置所有按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
}
@end
