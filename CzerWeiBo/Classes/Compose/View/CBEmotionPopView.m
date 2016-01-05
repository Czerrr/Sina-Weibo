//
//  CBEmotionPopView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/12.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionPopView.h"
#import "CBEmotion.h"
#import "CBEmotionButton.h"

@interface CBEmotionPopView ()
@property (weak, nonatomic) IBOutlet CBEmotionButton *emotionButton;

@end

@implementation CBEmotionPopView

+ (instancetype)popView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CBEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(CBEmotionButton *)button {
    if (button == nil) {
        return;
    }
    
    self.emotionButton.emotion = button.emotion;
    
    // 取得最上层的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    
    CGRect buttonFrame = [button convertRect:button.bounds toView:window];
    
    self.y = CGRectGetMidY(buttonFrame) - self.height;
    self.centerX = CGRectGetMidX(buttonFrame);
    

}


@end
