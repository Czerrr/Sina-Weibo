//
//  CBUser.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/31.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBUser.h"
/**
 *  用户模型
 */
@implementation CBUser

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    self.vip = (mbtype > 2);
}

+ (instancetype)userWithDict:(NSDictionary *)dict {
    CBUser *user = [[CBUser alloc] init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    user.mbtype = [dict[@"mbtype"] intValue];
    user.mbrank = [dict[@"mbrank"] intValue];
    user.verified_type = [dict[@"verified_type"] intValue];
    return user;
}

@end
