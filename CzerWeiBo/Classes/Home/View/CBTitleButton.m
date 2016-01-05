//
//  CBTitleButton.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/30.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBTitleButton.h"

@implementation CBTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 点击首页按钮时箭头图片上下切换
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        
//        self.titleLabel.backgroundColor = [UIColor redColor];
//        self.backgroundColor = [UIColor blueColor];
//        self.imageView.backgroundColor = [UIColor orangeColor];
        
    }
    return self;
}

// 目的：想在系统计算和设置完按钮尺寸以后，再修改一下尺寸
// 重写setFrame方法目的：拦截设置按钮尺寸的过程
- (void)setFrame:(CGRect)frame {
    frame.size.width += 10;
    [super setFrame:frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 如果仅仅调整按钮内部的控件位置，那么在layoutSubviews内单独设置即可
/*
    // 1. 计算titleLabel的frame
    self.titleLabel.x = 0;
    
    // 2. 计算imageView的frame
    self.imageView.x = self.titleLabel.width + 10;
*/
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}

// 重写setTitle setImageView方法，添加宽高自适应，保证内容改变时按钮宽高自动变化
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end



/**
 *  设置按钮内部imageView的frame
 *
 *  @param contentRect 按钮的bounds
 *
 */
//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    CGFloat x = 80;
//    CGFloat y = 0;
//    CGFloat width = 15;
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}

/**
 *  设置按钮内部titleLabel的frame
 *
 *  @param contentRect 按钮的bounds
 *
 */
//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat width = 80;
//    CGFloat height = contentRect.size.height;
//    return CGRectMake(x, y, width, height);
//}





