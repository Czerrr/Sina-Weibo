//
//  CBComposeToolbar.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/9.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CBComposeToolbarButtonTypeCamera,
    CBComposeToolbarButtonTypePicture,
    CBComposeToolbarButtonTypeMention,
    CBComposeToolbarButtonTypeTrend,
    CBComposeToolbarButtonTypeEmotion
} CBComposeToolbarButtonType;

@class CBComposeToolbar;

@protocol CBComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(CBComposeToolbar *)toolbar didClickButton:(CBComposeToolbarButtonType)buttonType;
@end

@interface CBComposeToolbar : UIView
@property (nonatomic, weak) id<CBComposeToolbarDelegate> delegate;

/** 是否为自定义的表情键盘 */
@property (nonatomic, assign) BOOL isEmotionKeyboard;
@end
