//
//  CBEmotionTextView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/13.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionTextView.h"
#import "CBEmotion.h"
#import "CBEmotionTextAttachment.h"

@implementation CBEmotionTextView

- (void)insertEmotion:(CBEmotion *)emotion {
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    } else if(emotion.png) {
        // 加载图片
        CBEmotionTextAttachment *attach = [[CBEmotionTextAttachment alloc] init];
        attach.emotion = emotion;
        
        // 设置图片尺寸
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        NSAttributedString *imageStr =[NSAttributedString attributedStringWithAttachment:attach];
        
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            // 设置字体大小属性
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
        

    }

}

- (NSString *)fullText {
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        CBEmotionTextAttachment *attach = attrs[@"NSAttachment"];
        if (attach) {
            [fullText appendString:attach.emotion.chs];
        } else {
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
                                 
    return fullText;
}

@end
