//
//  CBEmotionKeyboard.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/10.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionKeyboard.h"
#import "CBEmotionListView.h"
#import "CBEmotionTabBar.h"
#import "CBEmotion.h"
#import "CBEmotionTool.h"

@interface CBEmotionKeyboard () <CBEmotionTabBarDelegate>

/** 容纳表情内容的控件 */
@property (nonatomic, weak) UIView *contentView;

/** 表情内容 */
@property (nonatomic, strong) CBEmotionListView *recentListView;
@property (nonatomic, strong) CBEmotionListView *defaultListView;
@property (nonatomic, strong) CBEmotionListView *emojiListView;
@property (nonatomic, strong) CBEmotionListView *lxhListView;

@property (nonatomic, weak) CBEmotionTabBar *tabBar;
@end

@implementation CBEmotionKeyboard

#pragma mark - 懒加载
- (CBEmotionListView *)recentListView {
    if (!_recentListView) {
        _recentListView = [[CBEmotionListView alloc] init];
        _recentListView.emotions = [CBEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (CBEmotionListView *)defaultListView {
    if (!_defaultListView) {
        _defaultListView = [[CBEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];        
        NSArray *defaultEmotions = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *emotionArray = [NSMutableArray array];
        for (NSDictionary *dict in defaultEmotions) {
            CBEmotion *emotion = [CBEmotion emotionWithDict:dict];
            [emotionArray addObject:emotion];
        }
        self.defaultListView.emotions = emotionArray;
    }
    return _defaultListView;
}

- (CBEmotionListView *)emojiListView {
    if (!_emojiListView) {
        _emojiListView = [[CBEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];

        NSArray *emojiEmotions = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *emotionArray = [NSMutableArray array];
        for (NSDictionary *dict in emojiEmotions) {
            CBEmotion *emotion = [CBEmotion emotionWithDict:dict];
            [emotionArray addObject:emotion];
        }
        self.emojiListView.emotions = emotionArray;
    }
    return _emojiListView;
}

- (CBEmotionListView *)lxhListView {
    if (!_lxhListView) {
        _lxhListView = [[CBEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *emotionArray = [NSMutableArray array];
        for (NSDictionary *dict in lxhEmotions) {
            CBEmotion *emotion = [CBEmotion emotionWithDict:dict];
            [emotionArray addObject:emotion];
        }
        self.lxhListView.emotions = emotionArray;
    }
    return _lxhListView;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 创建contentView
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        // 表情底部tabbar
        CBEmotionTabBar *tabBar = [[CBEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 监听表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:@"CBEmotionDidSelectNotification" object:nil];
    }
    return self;
}

/**
 *  监听表情选中通知时的回调
 */
- (void)emotionDidSelect {
    // 加载沙盒中的数据
    self.recentListView.emotions = [CBEmotionTool recentEmotions];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.tabbar
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.width = self.width;
    
    // 2.表情内容
    self.contentView.x = 0;
    self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
    
    // 3.设置四种listView的frame
    UIView *child = [[self.contentView subviews] lastObject];
    child.frame = self.contentView.bounds;
}

#pragma mark - 实现CBEmotionTabBarDelegate
- (void)emotionTabBar:(CBEmotionTabBar *)tabBar didSelectButton:(CBEmotionTabBarButtonType)buttonType {
    
    // 移除contentView之前显示的控件
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 根据按钮类型切换contentView上面的listView
    switch (buttonType) {
        case CBEmotionTabBarButtonTypeRecent: {
            [self.contentView addSubview:self.recentListView];
            break;
        }
        case CBEmotionTabBarButtonTypeDefault: {
            [self.contentView addSubview:self.defaultListView];
            break;
        }
        case CBEmotionTabBarButtonTypeEmoji: {
            [self.contentView addSubview:self.emojiListView];
            break;
        }
        case CBEmotionTabBarButtonTypeLxh: {
            [self.contentView addSubview:self.lxhListView];
            break;
        }
        default:
            break;
    }
    
    // 重新计算子控件的frame(该函数会在恰当时刻重调layoutSubviews)
    [self setNeedsLayout];
}

@end
