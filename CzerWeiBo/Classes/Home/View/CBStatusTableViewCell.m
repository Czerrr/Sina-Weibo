//
//  CBStatusTableViewCell.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/3.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBStatusTableViewCell.h"
#import "CBStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "CBStatus.h"
#import "CBUser.h"
#import "CBPhoto.h"
#import "CBStatusToolbar.h"
#import "CBStatusPhotosView.h"
#import "CBIconView.h"

@interface CBStatusTableViewCell ()
/* 原创微博 */
/**
*  原创微博整体
*/
@property (nonatomic, weak) UIView *originalView;
/**
 *  头像
 */
@property (nonatomic, weak) CBIconView *iconView;
/**
 *  会员图标
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  配图
 */
@property (nonatomic, weak) CBStatusPhotosView *photosView;
/**
 *  用户昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  微博发布时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  微博发布来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  微博正文
 */
@property (nonatomic, weak) UILabel *contentLabel;


/* 转发微博 */
/**
 *  转发微博整体
 */
@property (nonatomic, weak) UIView *retweetView;

/**
 *  转发微博内容
 */
@property (nonatomic, weak) UILabel *retweetContentLabel;

/**
 *  转发微博配图
 */
@property (nonatomic, weak) CBStatusPhotosView *retweetPhotosView;



/** 工具条 */
@property (nonatomic, weak) CBStatusToolbar *toolbar;

@end

@implementation CBStatusTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"statusCell";
    CBStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CBStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

// 重写initWithStyle方法
/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // cell背景色
        self.backgroundColor = [UIColor clearColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];
        
        // 初始化工具条
        [self setupToolbar];
        
    }
    return self;
}

/**
 *  cell顶部留出间距
 *
 */
- (void)setFrame:(CGRect)frame {
    frame.origin.y += CBStatusCellBottomMargin;
    [super setFrame:frame];
}

/**
 *  初始化工具条
 */
- (void)setupToolbar {
    CBStatusToolbar *toolbar = [CBStatusToolbar toolbar];
    self.toolbar = toolbar;
    [self.contentView addSubview:toolbar];
}

/**
 *  初始化转发微博
 */
- (void)setupRetweet {
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    self.retweetView = retweetView;
    
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = CBStatusCellRetweetContentFont;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    CBStatusPhotosView *retweetPhotosView = [[CBStatusPhotosView alloc] init];
    [self.retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

/**
 *  初始化原创微博
 */
- (void)setupOriginal {
    // 1.原创微博的整体
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    self.originalView.backgroundColor = [UIColor whiteColor];
    
    CBIconView *iconView = [[CBIconView alloc] init];
    [self.originalView addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self.originalView addSubview:vipView];
    self.vipView = vipView;
    
    CBStatusPhotosView *photosView = [[CBStatusPhotosView alloc] init];
    [self.originalView addSubview:photosView];
    self.photosView = photosView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = CBStatusCellNameFont;
    [self.originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = CBStatusCellTimeFont;
    [self.originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = CBStatusCellSourceFont;
    [self.originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = CBStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [self.originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;

}

/**
 *  设置cell内部的frame与数据
 *
 */
- (void)setStatusFrame:(CBStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    CBStatus *status = statusFrame.status;
    CBUser *user = status.user;
    
    // 原创微博整体
    self.originalView.frame = statusFrame.originalViewFrame;
    
    // 头像
    self.iconView.frame = statusFrame.iconViewFrame;
    self.iconView.user = user;
    
    // 会员图标
    // 有无会员图标要注意设置hidden属性，因为可能会循环利用cell
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewFrame;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }

    // 配图
    // 注意设置hidden属性，循环利用
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewFrame;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }

    
    // 用户昵称
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    self.nameLabel.text = user.name;
    
    
    // 每次都要从新计算时间和来源的frame，因为时间不断变化，text字数也会变，如 1分钟前 10分钟前
    // 时间尺寸
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelFrame.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelFrame) + CBStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:CBStatusCellTimeFont];
    statusFrame.timeLabelFrame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    // 微博发布时间
    self.timeLabel.frame = statusFrame.timeLabelFrame;
    self.timeLabel.text = time;
    self.timeLabel.textColor = [UIColor orangeColor];
    
    
    // 来源尺寸
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLabelFrame) + CBStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:CBStatusCellSourceFont];
    statusFrame.sourceLabelFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    // 微博发布来源
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    self.sourceLabel.text = status.source;
    
    // 微博正文
    self.contentLabel.frame = statusFrame.contentLabelFrame;
//    self.contentLabel.text = status.text;
    
    self.contentLabel.attributedText = status.attributedText;
    
    
    
    // 被转发微博
//    CBUser *retweetUser = retweetStatus.user;

    if (status.retweeted_status) { // 存在转发微博
        CBStatus *retweetStatus = status.retweeted_status;
        
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewFrame;
        
        // 转发微博内容(格式为 昵称：正文)
//        NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@", retweetUser.name, retweetStatus.text];
//        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.attributedText = status.retweetedAttributedText;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelFrame;
        
        // 转发微博配图(存在与否)
        if (retweetStatus.pic_urls.count) {
            self.retweetPhotosView.hidden = NO;
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewFrame;
            self.retweetPhotosView.photos = retweetStatus.pic_urls;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
        
    } else {
        self.retweetView.hidden = YES;
    }
    
    // toolbar的尺寸
    self.toolbar.frame = statusFrame.toolbarFrame;
    self.toolbar.status = status;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
