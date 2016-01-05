//
//  CBStatusPhotosView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/7.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// cell上的配图相册，里面会显示1～9张图片
#import <UIKit/UIKit.h>

@interface CBStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;
/**
 *  根据图片个数设置微博相册大小
 *
 */
+ (CGSize)sizeWithCount:(long)count;
@end
