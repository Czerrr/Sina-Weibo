//
//  CBStatusPhotoView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/8.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBStatusPhotoView.h"
#import "CBPhoto.h"
#import "UIImageView+WebCache.h"

@interface CBStatusPhotoView ()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation CBStatusPhotoView

- (UIImageView *)gifView {
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置内容模式
        // 这种模式不会破坏原图的宽高比
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框部分全部剪掉
        self.clipsToBounds = YES;
        
        // 能够接收手势触控
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setPhoto:(CBPhoto *)photo {
    _photo = photo;
    
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 显示\隐藏gif
//    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {
//        self.gifView.hidden = NO;
//    } else {
//        self.gifView.hidden = YES;
//    }
    
    // 不管是否大小写gif结尾
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

/**
 *  子控件的尺寸都在这里设置最好，因为只要父控件尺寸变了，子控件在这里也会跟着变
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}
@end
