//
//  CBPhoto.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/4.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBPhoto : NSObject
/**
 *  缩略图地址
 */
@property (nonatomic, copy) NSString *thumbnail_pic;

+ (instancetype)photoWithDict:(NSDictionary *)dict;

@end
