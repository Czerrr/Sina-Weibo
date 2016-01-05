//
//  CBAccount.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/30.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBAccount : NSObject <NSCoding>

/**
 *  接口获取授权后的access_token
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  access_token的生命周期，单位是秒
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  当前授权用户的uid
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  access_token的创建时间
 */
@property (nonatomic, strong) NSDate *create_time;

/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
