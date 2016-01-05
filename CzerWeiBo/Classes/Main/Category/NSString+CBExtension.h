//
//  NSString+CBExtension.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/7.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CBExtension)
/**
 *  计算正文的size
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  计算除正文外其他地方文字的size（不需要换行）
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  计算该路径下所有文件/文件夹的总大小
 *
 */
- (NSInteger)fileSize;
@end
