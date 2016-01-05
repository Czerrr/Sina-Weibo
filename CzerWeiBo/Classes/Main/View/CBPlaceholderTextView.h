//
//  CBPlaceholderTextView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/9.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 带有占位文字功能的textView
#import <UIKit/UIKit.h>

@interface CBPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
