//
//  CBDropdownMenu.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/27.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBDropdownMenu.h"

@interface CBDropdownMenu ()
/**
 *  用来显示具体内容的容器 （下拉菜单弹出框）
 */
@property (nonatomic, strong) UIImageView *containerView;
@end

// 蒙板和下拉框菜单的工具类
@implementation CBDropdownMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

// containerView懒加载
- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background"]];
//        _containerView.backgroundColor = [UIColor yellowColor];
        _containerView.userInteractionEnabled = YES;
        [self addSubview:_containerView];

    }
    return _containerView;
}

/**
 *  content set方法
 *
 */
- (void)setContent:(UIView *)content {
    _content = content;
    
    // 调整内容距离下拉菜单弹出框（containerView）的间距
    _content.x = 8;
    _content.y = 15;
    
    
    // 设置下拉菜单弹出框的尺寸
    self.containerView.height = CGRectGetMaxY(_content.frame) + 11;
    self.containerView.width = CGRectGetMaxX(_content.frame) + 8;
    
    // 添加内容到下拉菜单弹出框中
    [self.containerView addSubview:_content];
}

- (void)setContentController:(UIViewController *)contentController {
    _contentController = contentController;
    self.content = contentController.view;
}

/**
 *  初始化类方法
 *
 */
+ (instancetype)dropdownMenu {

    return [[self alloc] init];
}

/**
 *  蒙板显示在最上层window上
 */
- (void)showFrom:(UIView *)from {
    // 取得最上层window
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows lastObject];
    
    // 设置蒙板的尺寸
    self.frame = lastWindow.bounds;
    
    // 设置蒙板中内容的位置 默认情况下frame的参考坐标系是相对于父控件来说
    // 需要转换坐标系原点
    CGRect newFrame = [from convertRect:from.bounds toView:lastWindow];
    
    // 蒙板中内容的中点的x
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    // 蒙板添加到window
    [lastWindow addSubview:self];
    
    // 通知外界，自己被显示了
    if ([self.myDelegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.myDelegate dropdownMenuDidShow:self];
    }

}

/**
 *  移除蒙板view
 */
- (void)dismiss {
    [self removeFromSuperview];
    // 通知代理将首页按钮箭头图片向下
    if ([self.myDelegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.myDelegate dropdownMenuDidDismiss:self];
    }
}

/**
 *  点击其他地方移除蒙板view
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}
@end
