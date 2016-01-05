//
//  NSString+CBExtension.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/7.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "NSString+CBExtension.h"

@implementation NSString (CBExtension)
/**
 *  计算正文的size
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**
 *  计算除正文外其他地方文字的size（不需要换行）
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/**
 *  计算该路径下所有文件/文件夹的总大小
 *
 */
- (NSInteger)fileSize {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSInteger totalByteSize = 0;

    // 1.判断是不是一个合法路径
    BOOL isDir = NO;
    // 判断该路径是否为合法文件
    BOOL isExists = [manager fileExistsAtPath:self isDirectory:&isDir];
    if (isExists == NO) {
        return 0;
    }
    
    // 2.判断是否直接为文件路径（非文件夹，不需考虑子文件问题）
    if (isDir == NO) {
        return [[manager attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
    
    // 3.路径合法，且是文件夹路径，包含子文件/文件夹
    // 获取该字符串路径下所有的子文件／文件夹路径(相对路径)
    NSArray *subpaths = [manager subpathsAtPath:self];
    for (NSString *subpath in subpaths) {
        // 获取所有子文件／文件夹的全路径
        NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
        BOOL isDir = NO;
        // 判断该路径是否为子文件（非文件夹）
        [manager fileExistsAtPath:fullSubpath isDirectory:&isDir];
        // 根据返回的isDir
        if (isDir == NO) { // 非文件夹
            // totalByteSize总字节数增加
            // attributesOfItemAtPath方法返回字典，取NSFileSize键对应的值
            totalByteSize += [[manager attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
        }
    }
    
    return totalByteSize;
}
@end




