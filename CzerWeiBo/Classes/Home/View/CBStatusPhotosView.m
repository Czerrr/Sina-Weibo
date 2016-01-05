//
//  CBStatusPhotosView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/7.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBStatusPhotosView.h"
#import "CBPhoto.h"
#import "CBStatusPhotoView.h"
#import "SDPhotoBrowser.h"
#import "UIImageView+WebCache.h"

/**
 *  微博内容中每张图片的宽高
 *
 */
#define CBStatusPhotoHW 70

/**
 *  微博内容中每张图片的间距
 *
 *
 */
#define CBStatusPhotoMargin 10

/**
 *  相册的最大列数
 *
 */
#define CBStatusPhotoMaxCol(count) ((count==4)?2:3)

@interface CBStatusPhotosView () <SDPhotoBrowserDelegate>

@end

@implementation CBStatusPhotosView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos {
    
    _photos = photos;

    int photosCount = (int)photos.count;
    
    // 创建足够数量的imageView(若self.subviews.count > photos.count表示循环利用的cell)
    while (self.subviews.count < photosCount) {
        CBStatusPhotoView *photoView = [[CBStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        CBStatusPhotoView *photoView = self.subviews[i];
        // 设置图片的tag，便于下面手势控制回调函数识别点击了哪张图
        photoView.tag = i;
        
        // 给每张图片添加tap手势
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhotoView:)]];
 
        if (i < photosCount) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }
    }
}


// 设置图片的尺寸和位置
- (void)layoutSubviews {
    [super layoutSubviews];
    int maxCol = CBStatusPhotoMaxCol(self.photos.count);
    for (int i = 0; i < self.photos.count; i++) {
        CBStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        int row = i / maxCol;
        
        photoView.x = col * (CBStatusPhotoHW + CBStatusPhotoMargin);
        photoView.y = row * (CBStatusPhotoHW + CBStatusPhotoMargin);
        photoView.width = CBStatusPhotoHW;
        photoView.height = CBStatusPhotoHW;

    }
}

/**
 *  根据图片个数设置微博相册大小
 *
 */
+ (CGSize)sizeWithCount:(long)count {
    int maxCols = CBStatusPhotoMaxCol(count);
    // 列数
    long cols = count > maxCols? maxCols : count;
    CGFloat photosW = cols * CBStatusPhotoHW + (cols - 1) * CBStatusPhotoMargin;
    
    // 行数
    //    long rows = count / 3;
    //    if (count % 3 != 0) {
    //        rows += 1;
    //    }
    long rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * CBStatusPhotoHW + (rows - 1) * CBStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

#pragma mark - tapGestureRecognizer的回调方法
- (void)tapPhotoView:(UITapGestureRecognizer *)recognizer {
    // 处理图片点击后的放大
    // 根据SDPhotoBrowser框架设置图片浏览器
    SDPhotoBrowser *photoBrowser = [[SDPhotoBrowser alloc] init];
    photoBrowser.sourceImagesContainerView = self;
    photoBrowser.imageCount = self.photos.count;
    photoBrowser.currentImageIndex = (int)recognizer.view.tag;
    photoBrowser.delegate = self;
    [photoBrowser show];
}

#pragma mark - SDPhotoBrowser代理方法
// 返回占位图片
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
//    return [UIImage imageNamed:@"timeline_image_placeholder"];
//    NSURL *url = [NSURL URLWithString:[self.photos[index] thumbnail_pic]];
//    return [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    CBStatusPhotoView *photoView = self.subviews[index];
    return photoView.image;
}

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    
    return [NSURL URLWithString:[[self.photos[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
}
@end




