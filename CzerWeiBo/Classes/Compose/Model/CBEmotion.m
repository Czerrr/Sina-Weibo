//
//  CBEmotion.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/11.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotion.h"

@interface CBEmotion () <NSCoding>

@end

@implementation CBEmotion
+ (instancetype)emotionWithDict:(NSDictionary *)dict {
    CBEmotion *emotion = [[CBEmotion alloc] init];
    emotion.chs = dict[@"chs"];
    emotion.png = dict[@"png"];
    emotion.code = dict[@"code"];
    
    return emotion;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
}

/**
 *  用来比较两个对象是否一样
 *
 *
 */
- (BOOL)isEqual:(CBEmotion *)object {
    return (([self.chs isEqualToString:object.chs]) || ([self.code isEqualToString:object.code]));
}
@end
