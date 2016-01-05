//
//  CBPhoto.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/4.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBPhoto.h"

@implementation CBPhoto

+ (instancetype)photoWithDict:(NSDictionary *)dict {
    CBPhoto *photo = [[CBPhoto alloc] init];
    photo.thumbnail_pic = dict[@"thumbnail_pic"];
    return photo;
}

@end
