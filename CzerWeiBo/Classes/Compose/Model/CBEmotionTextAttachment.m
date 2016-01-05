//
//  CBEmotionTextAttachment.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/13.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionTextAttachment.h"
#import "CBEmotion.h"
@implementation CBEmotionTextAttachment
- (void)setEmotion:(CBEmotion *)emotion {
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
