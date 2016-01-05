//
//  CBAccount.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/30.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBAccount.h"

@implementation CBAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict {
    CBAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    // 获得账号存储的时间(accessToken的产生时间)
    account.create_time = [NSDate date];
    return account;
}

/**
 *  当一个对象要归档进入沙盒时，会调用
    目的：在这个方法中说明这个对象的哪些属性要归档进去
 *
 *  @param aCoder 编码器
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中调用一个对象），就会调用此方法
    目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 *
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.create_time = [aDecoder decodeObjectForKey:@"create_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
