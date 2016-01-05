//
//  CBEmotionButton.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/12.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionButton.h"
#import "CBEmotion.h"

@implementation CBEmotionButton

/**
 *  当控件不是从xib storyboard中创建时调用该初始化方法
 *
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  当控件从xib storyboard中创建时调用该初始化方法
 *
 *
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  初始化一些东西
 */
- (void)setup {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    // 按钮高亮的时候，图片不会变色
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setEmotion:(CBEmotion *)emotion {
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) {
        [self setTitle:[emotion.code emoji] forState:UIControlStateNormal];
    }

}
@end
