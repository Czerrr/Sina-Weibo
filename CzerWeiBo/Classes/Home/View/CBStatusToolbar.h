//
//  CBStatusToolbar.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/5.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBStatus;

@interface CBStatusToolbar : UIView

+ (instancetype)toolbar;

@property (nonatomic, strong) CBStatus *status;
@end
