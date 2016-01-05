//
//  UIBarButtonItem+CBExtension.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/26.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CBExtension)
/**
 *  创建自定义的UIBarButtonItem
 *
 *  @param image          常态图片
 *  @param highLightImage 选中下图片
 *  @param target         按钮点击监听者
 *  @param action         按钮点击回调函数
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highLightedImage:(UIImage *)highLightImage addTarget:(id)target action:(SEL)action;
@end
