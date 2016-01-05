//
//  CBEmotionPopView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/12.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBEmotion, CBEmotionButton;
@interface CBEmotionPopView : UIView
+ (instancetype)popView;

- (void)showFrom:(CBEmotionButton *)button;
@end
