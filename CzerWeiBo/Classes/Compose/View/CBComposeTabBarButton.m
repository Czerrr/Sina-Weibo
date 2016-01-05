//
//  CBComposeTabBarButton.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/11.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBComposeTabBarButton.h"

@implementation CBComposeTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置文字的颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

/**
 *  重写highlighted方法，使点击按钮时不显示高亮色
 *
 */
- (void)setHighlighted:(BOOL)highlighted {

}

@end
