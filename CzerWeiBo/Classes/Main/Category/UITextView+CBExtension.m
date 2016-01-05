//
//  UITextView+CBExtension.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/13.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "UITextView+CBExtension.h"

@implementation UITextView (CBExtension)
- (void)insertAttributedText:(NSAttributedString *)text {
    [self insertAttributedText:text settingBlock:nil];
}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock {
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    // 拼接之前的属性文字（包含图片和普通文字）
    [attributedText appendAttributedString:self.attributedText];
    
    // 将text插入到当前光标后面
    NSUInteger location = self.selectedRange.location;
//    [attributedText insertAttributedString:text atIndex:location];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    // 调用block
    if (settingBlock) {
        settingBlock(attributedText);
    }
    
    self.attributedText = attributedText;
    
    // 移动光标到表情后面
    self.selectedRange = NSMakeRange(location + 1, 0);
}
@end
