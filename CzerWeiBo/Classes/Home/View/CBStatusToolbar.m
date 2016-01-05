//
//  CBStatusToolbar.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/5.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBStatusToolbar.h"
#import "CBStatus.h"

@interface CBStatusToolbar ()
/**
 *  里面存放所有的按钮
 */
@property (nonatomic, strong) NSMutableArray *btns;

/**
 *  里面存放所有的分割线
 */
@property (nonatomic, strong) NSMutableArray *dividers;

/**
 *  转发按钮
 */
@property (nonatomic, weak) UIButton *repostBtn;

/**
 *  评论按钮
 */
@property (nonatomic, weak) UIButton *commentBtn;

/**
 *  点赞按钮
 */
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation CBStatusToolbar

- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers {
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)toolbar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        // 转发按钮
        self.repostBtn = [self setupButton:@"首页" icon:[UIImage imageNamed:@"timeline_icon_retweet"]];
        // 评论按钮
        self.commentBtn = [self setupButton:@"评论" icon:[UIImage imageNamed:@"timeline_icon_comment"]];
        // 点赞按钮
        self.attitudeBtn = [self setupButton:@"赞" icon:[UIImage imageNamed:@"timeline_icon_unlike"]];
        
        // 添加分割线
        [self setupDivider];
        
        // 添加分割线
        [self setupDivider];
    }
    return self;
}

- (void)setupDivider {
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始化按钮
 */
- (UIButton *)setupButton:(NSString *)title icon:(UIImage *)icon {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:icon forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    // 设置title和图片间距
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:button];
    
    [self.btns addObject:button];
    
    return button;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的frame
    int btnCount = (int)self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    // 设置分割线的frame
    int dividerCount = (int)self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.x = (i + 1) * btnW;
        divider.y = 0;
        divider.width = 1;
        divider.height = btnH;
    }
    
}

- (void)setStatus:(CBStatus *)status {
    _status = status;
    
    // 转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    
    // 评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
}

/**
 *  设置工具条按钮的文字title
 *
 */
- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title {
    if (count) {
        /**
         不足一万直接显示数字
         达到一万显示xx.x万
         */
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        } else {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 去除字符串里的.0
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    
}

@end




