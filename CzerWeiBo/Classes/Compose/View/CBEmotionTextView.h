//
//  CBEmotionTextView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/13.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 自定义的内容输入框，继承自自定义的带占位符功能的UIView
#import "CBPlaceholderTextView.h"
@class CBEmotion;
@interface CBEmotionTextView : CBPlaceholderTextView
- (void)insertEmotion:(CBEmotion *)emotion;

- (NSString *)fullText;
@end
