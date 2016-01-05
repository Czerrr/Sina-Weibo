//
//  CBLoadMoreFooter.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/1.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBLoadMoreFooter.h"

@implementation CBLoadMoreFooter

+ (instancetype)footer {
    return [[[NSBundle mainBundle] loadNibNamed:@"CBLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
