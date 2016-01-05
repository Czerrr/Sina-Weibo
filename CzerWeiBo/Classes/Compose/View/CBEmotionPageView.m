//
//  CBEmotionPageView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/12.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionPageView.h"
#import "CBEmotion.h"
#import "CBEmotionPopView.h"
#import "CBEmotionButton.h"
#import "CBEmotionTool.h"

@interface CBEmotionPageView ()
/** 点击表情按钮后弹出的放大镜 */
@property (nonatomic, strong) CBEmotionPopView *popView;

/** 键盘的删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation CBEmotionPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加键盘的删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}

/**
 *  根据手指所在位置找出对应的按钮
 *
 *
 */
- (CBEmotionButton *)emotionButtonWithLocation:(CGPoint)location {
    // 判断手指位置在哪个按钮范围内 CGRectContainsPoint
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        CBEmotionButton *button = self.subviews[i + 1];
        if (CGRectContainsPoint(button.frame, location)) {
            return button;
        }
    }
    return nil;
}

- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer {
    // 获得手指所在的位置
    CGPoint location = [recognizer locationInView:recognizer.view];
    CBEmotionButton *button = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            [self.popView removeFromSuperview];
            
            // 如果手指还在按钮上，发出点击该按钮的通知
            if (button) {
                [self selectEmotion:button.emotion];
            }
            break;
            
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {

            [self.popView showFrom:button];
            break;
        }
            
        default:
            break;
    }
}

- (CBEmotionPopView *)popView {
    if (!_popView) {
        self.popView = [CBEmotionPopView popView];
    }
    return _popView;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        CBEmotionButton *btn = [[CBEmotionButton alloc] init];
        [self addSubview:btn];

        // 设置表情数据
        btn.emotion = emotions[i];
        
        // 监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/**
 *  监听删除按钮的点击
 *
 */
- (void)deleteButtonClick {
    // 删除文字的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CBEmotionDidDeleteNotification" object:nil];
}

/**
 *  监听表情按钮的点击
 */
- (void)btnClick:(CBEmotionButton *)button {
    
    // 显示popView
    [self.popView showFrom:button];
    
    // 等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    // 发通知
    [self selectEmotion:button.emotion];
}

/**
 *  选中某个表情，发出通知
 *
 */
- (void)selectEmotion:(CBEmotion *)emotion {
    // 将这个表情存入沙盒，作为recent
    [CBEmotionTool addRecentEmotion:emotion];
    
    // 发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"selectEmotion"] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CBEmotionDidSelectNotification" object:nil userInfo:userInfo];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 四周整体的内边距
    CGFloat padding = 10;
    CGFloat btnW = (self.width - 2 * padding) / 7;
    CGFloat btnH = (self.height - padding) / 3;
    
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        CBEmotionButton *btn = self.subviews[i + 1];
        btn.x = padding + (i % 7) * btnW;
        btn.y = padding + (i / 7) * btnH;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    // 设置删除按钮的尺寸
    self.deleteButton.x = self.width - padding - btnW;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
}
@end
