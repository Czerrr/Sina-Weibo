//
//  CBEmotionListView.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/10.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBEmotionListView.h"
#import "CBEmotionPageView.h"

@interface CBEmotionListView () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation CBEmotionListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        // 去除水平方向滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        self.scrollView = scrollView;
        
        // pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        pageControl.userInteractionEnabled = NO;
        // 当只有一页时自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        self.pageControl = pageControl;
        // 设置内部原点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
    }
    return self;
}

/**
 *  根据emotions,创建对应个数的表情
 *
 */
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 页码
    NSUInteger count = (emotions.count + CBEmotionPageSize - 1) / CBEmotionPageSize;
    
    // 设置页数
    self.pageControl.numberOfPages = count;
    
    
    // 创建用来显示每一页表情的控件
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        CBEmotionPageView *pageView = [[CBEmotionPageView alloc] init];
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * CBEmotionPageSize;
        // 最后一页的表情个数小于等于20，所以要单独处理
        range.length = (emotions.count - range.location >= CBEmotionPageSize)?CBEmotionPageSize:(emotions.count - range.location);
        // 设置这一页的表情
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // pageControl
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    
    // scrollView
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    // 设置scrollView中每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        CBEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = pageView.width * i;
        pageView.y = 0;
    }
    
    // 设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}

#pragma mark - scrollViewDelegate
// 修改pageControl的页码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageNum = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNum + 0.5);
}

@end
