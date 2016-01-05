//
//  CBStatusFrame.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/3.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 一个CBStatusFrame模型就存放着
// 1.一个cell内部所有子控件的frame数据
// 2.一个cell的高度
// 3.存放着一个数据模型 CBStatus
#import <Foundation/Foundation.h>

// cell边框宽度 间距
#define CBStatusCellBorderW 10

// 昵称字体
#define CBStatusCellNameFont [UIFont systemFontOfSize:15]

// 时间字体
#define CBStatusCellTimeFont [UIFont systemFontOfSize:12]

// 来源字体
#define CBStatusCellSourceFont [UIFont systemFontOfSize:12]

// 正文字体
#define CBStatusCellContentFont [UIFont systemFontOfSize:14]

// 转发微博正文字体
#define CBStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

// cell底部的间距
#define CBStatusCellBottomMargin 15

@class CBStatus;

@interface CBStatusFrame : NSObject

@property (nonatomic, strong) CBStatus *status;

/**
 *  原创微博整体尺寸
 */
@property (nonatomic, assign) CGRect originalViewFrame;
/**
 *  头像尺寸
 */
@property (nonatomic, assign) CGRect iconViewFrame;
/**
 *  会员图标尺寸
 */
@property (nonatomic, assign) CGRect vipViewFrame;
/**
 *  配图尺寸
 */
@property (nonatomic, assign) CGRect photosViewFrame;
/**
 *  用户昵称尺寸
 */
@property (nonatomic, assign) CGRect nameLabelFrame;
/**
 *  微博发布时间尺寸
 */
@property (nonatomic, assign) CGRect timeLabelFrame;
/**
 *  微博发布来源尺寸
 */
@property (nonatomic, assign) CGRect sourceLabelFrame;
/**
 *  微博正文尺寸
 */
@property (nonatomic, assign) CGRect contentLabelFrame;




/* 转发微博 */
/**
 *  转发微博整体尺寸
 */
@property (nonatomic, assign) CGRect retweetViewFrame;

/**
 *  转发微博内容尺寸
 */
@property (nonatomic, assign) CGRect retweetContentLabelFrame;

/**
 *  转发微博配图尺寸
 */
@property (nonatomic, assign) CGRect retweetPhotosViewFrame;




/* 工具条 */
/**
 *  工具条尺寸
 */
@property (nonatomic, assign) CGRect toolbarFrame;

/**
 *  cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
