//
//  CBIconView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/8.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBIconView.h"
#import "CBUser.h"
#import "UIImageView+WebCache.h"

@interface CBIconView ()
@property (nonatomic, weak) UIImageView *verifiedView;
@end

@implementation CBIconView

- (UIImageView *)verifiedView {
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        _verifiedView = verifiedView;
    }
    return _verifiedView;
}


- (void)setUser:(CBUser *)user {
    _user = user;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 2.添加认证图片
    switch (user.verified_type) {
        case CBUserVerifiedTypeNone: // 没有认证
            self.verifiedView.hidden = YES;
            break;
            
        case CBUserVerifiedTypePersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case CBUserVerifiedTypeOrgEnterprice:
        case CBUserVerifiedTypeOrgMedia:
        case CBUserVerifiedTypeOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case CBUserVerifiedTypeDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}

@end
