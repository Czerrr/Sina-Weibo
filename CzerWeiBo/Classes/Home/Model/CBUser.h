//
//  CBUser.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/31.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CBUserVerifiedTypeNone = -1,
    
    CBUserVerifiedTypePersonal = 0,
    
    CBUserVerifiedTypeOrgEnterprice = 2,
    CBUserVerifiedTypeOrgMedia = 3,
    CBUserVerifiedTypeOrgWebsite = 5,
    
    CBUserVerifiedTypeDaren = 220
    
} CBUserVerifiedType;

@interface CBUser : NSObject

/**
 *  字符串类型用户uid
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  用户名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  用户头像地址 50*50像素
 */
@property (nonatomic, copy) NSString *profile_image_url;

/**
 *  会员类型 值大于2才代表是会员
 */
@property (nonatomic, assign) int mbtype;

/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter=isVip) BOOL vip;

/**
 *  认证类型
 */
@property (nonatomic, assign) CBUserVerifiedType verified_type;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
