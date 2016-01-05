//
//  CBPlaceholderTextView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/9.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBPlaceholderTextView.h"

@implementation CBPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder {
    // weak用copy
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    // strong直接赋值
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    // 重绘 即重新调用drawRect
    [self setNeedsDisplay];
}

// setNeedsDisplay会重新调用drawRect(但不是马上执行，而是在下一次消息循环mainRunLoop)，会擦出之绘制的东西
- (void)drawRect:(CGRect)rect {
    
    // 有输入文字则直接返回，目的是不绘制占位文字
    if (self.hasText) {
        return;
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor lightGrayColor];

    //限制占位文字的区域
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
