//
//  CBTabBar.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/28.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBTabBar.h"

@interface CBTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation CBTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 内部加载plusbutton按钮控件
        UIButton *plusButton = [[UIButton alloc] init];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        plusButton.size = plusButton.currentBackgroundImage.size;

        // plusButton的点击事件监听
        [plusButton addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusButton];
        
        self.plusButton = plusButton;

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // tabbar里面有7个子控件（还有两个是backgroundimage image）跟width有关的只有5个
    CGFloat childViewW = self.width / 5;
    int childViewIndex = 0;
    
    for (UIView *childView in self.subviews) {
        Class childClass = NSClassFromString(@"UITabBarButton");
        if ([childView isKindOfClass:childClass]) {
            childView.width = childViewW;
            childView.x = childViewIndex * childViewW;
            childViewIndex++;
        }
        
        // childViewIndex == 2 是plusButton的位置，在下方单独设置
        if (childViewIndex == 2) {
            childViewIndex++;
        }
    }
    
    // 设置plusButton按钮的位置
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = self.height * 0.5;
}

/**
 *  plusButton按钮点击事件回调
 */
- (void)plusButtonClicked {
    // 通知代理 交给控制器处理
    if ([self.myDelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.myDelegate tabBarDidClickPlusButton:self];
    }
}

@end
