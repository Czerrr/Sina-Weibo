//
//  CBEmotionButton.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/12.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 每一个表情按钮
#import <UIKit/UIKit.h>
@class CBEmotion;
@interface CBEmotionButton : UIButton
@property (nonatomic, strong) CBEmotion *emotion;
@end
