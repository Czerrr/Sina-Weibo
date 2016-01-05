//
//  CBComposePhotosView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/9.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBComposePhotosView.h"

@interface CBComposePhotosView ()
@end

@implementation CBComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}


- (void)addPhoto:(UIImage *)photo {
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
    [self.photos addObject:photoView.image];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i < count; i++) {
        UIImageView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
}



@end
