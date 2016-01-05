//
//  CBStatusFrame.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/3.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBStatusFrame.h"
#import "CBStatus.h"
#import "CBUser.h"
#import "CBStatusPhotosView.h"


@implementation CBStatusFrame



- (void)setStatus:(CBStatus *)status {
    _status = status;
    CBUser *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // 头像
    CGFloat iconWH = 35;
    CGFloat iconX = CBStatusCellBorderW;
    CGFloat iconY = CBStatusCellBorderW;
    self.iconViewFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewFrame) + CBStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:CBStatusCellNameFont];
    self.nameLabelFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    // 会员图标
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelFrame) + CBStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipViewFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelFrame) + CBStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:CBStatusCellTimeFont];
    self.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelFrame) + CBStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:CBStatusCellSourceFont];
    self.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    // 正文
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewFrame), CGRectGetMaxY(self.timeLabelFrame)) + CBStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:CBStatusCellContentFont maxW:maxW];
    self.contentLabelFrame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    // 配图
    // 有无配图下，原创微博整体高度不同
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGSize photosSize = [CBStatusPhotosView sizeWithCount:status.pic_urls.count];
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelFrame) + CBStatusCellBorderW;
        self.photosViewFrame = CGRectMake(photosX, photosY, photosSize.width, photosSize.height);
        
        originalH = CGRectGetMaxY(self.photosViewFrame) + CBStatusCellBorderW;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelFrame) + CBStatusCellBorderW;
    }
    
    // 原创微博整体
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    
    // 工具条的尺寸
    CGFloat toolbarX = 0;
    CGFloat toolbarY = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    
    
    /* 被转发微博 */
    CBStatus *retweetStatus = status.retweeted_status;
    CBUser *retweetUser = retweetStatus.user;
    
    if (status.retweeted_status) { // 存在被转发微博
        /** 被转发微博正文 */
        CGFloat retweetContentX = CBStatusCellBorderW;
        CGFloat retweetContentY = CBStatusCellBorderW;

        NSString *retweetContentStr = [NSString stringWithFormat:@"@%@:%@", retweetUser.name, retweetStatus.text];
        CGFloat retweetContentW = [retweetContentStr sizeWithFont:CBStatusCellRetweetContentFont maxW:maxW].width;
        CGFloat retweetContentH = [retweetContentStr sizeWithFont:CBStatusCellRetweetContentFont maxW:maxW].height;
        self.retweetContentLabelFrame = CGRectMake(retweetContentX, retweetContentY, retweetContentW, retweetContentH);

        /** 被转发微博配图 */
        CGFloat retweetViewH = 0; // 转发微博整体高度
        if (retweetStatus.pic_urls.count) {
            CGSize retweetPhotosSize = [CBStatusPhotosView sizeWithCount:retweetStatus.pic_urls.count];
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelFrame) + CBStatusCellBorderW;
            self.retweetPhotosViewFrame = CGRectMake(retweetPhotosX, retweetPhotosY, retweetPhotosSize.width, retweetPhotosSize.height);
            
            retweetViewH = CGRectGetMaxY(self.retweetPhotosViewFrame) + CBStatusCellBorderW;
            
        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(self.retweetContentLabelFrame);
        }
    
        /** 被转发微博整体 */
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewFrame);
        CGFloat retweetViewW = cellW;
        self.retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // toolbar的y
        toolbarY = CGRectGetMaxY(self.retweetViewFrame);
        
    } else { // 不存在被转发微博
        // toolbar的y
        toolbarY = CGRectGetMaxY(self.originalViewFrame);
    }

    
    /** 设置toolbar的frame */
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame) + CBStatusCellBottomMargin;

}
@end
