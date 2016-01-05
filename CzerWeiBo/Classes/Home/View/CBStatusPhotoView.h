//
//  CBStatusPhotoView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/8.
//  Copyright © 2015年 Czerrr. All rights reserved.
//


// cell配图相册里的单独一张图片（右下角可以带gif）
#import <UIKit/UIKit.h>
@class CBPhoto;

@interface CBStatusPhotoView : UIImageView
@property (nonatomic, strong) CBPhoto *photo;
@end
