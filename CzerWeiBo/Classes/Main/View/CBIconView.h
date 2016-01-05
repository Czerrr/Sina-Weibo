//
//  CBIconView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/8.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 微博用户头像的view(带认证图标)
#import <UIKit/UIKit.h>

@class CBUser;

@interface CBIconView : UIImageView
@property (nonatomic, strong) CBUser *user;

@end
