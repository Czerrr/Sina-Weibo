//
//  CBStatus.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/31.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBUser;

@interface CBStatus : NSObject

/**
 *  字符串类型的微博id
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  带有属性的微博信息内容
 */
@property (nonatomic, copy) NSAttributedString *attributedText;

/**
 *  微博作者的用户信息
 */
@property (nonatomic, strong) CBUser *user;

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  微博配图地址
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  转发微博
 */
@property (nonatomic, strong) CBStatus *retweeted_status;

/**
 *  带有属性的转发微博信息内容
 */
@property (nonatomic, copy) NSAttributedString *retweetedAttributedText;

/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数
 */
@property (nonatomic, assign) int attitudes_count;


+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
