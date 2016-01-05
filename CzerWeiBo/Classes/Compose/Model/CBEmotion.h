//
//  CBEmotion.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/11.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;

/** 表情的图片名称 */
@property (nonatomic, copy) NSString *png;

/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;

/**
 *  字典转模型
 */
+ (instancetype)emotionWithDict:(NSDictionary *)dict;
@end
