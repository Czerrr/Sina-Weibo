//
//  CBNewFeatureViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/28.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBNewFeatureViewController.h"
#import "CBTabBarController.h"

// 新特性图片个数
#define CBNewFeatureCount 4

@interface CBNewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation CBNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建一个scrollView：显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    // 添加图片到scrollView中
    CGFloat scrollWidth = scrollView.width;
    CGFloat scrollHeight = scrollView.height;
    
    for (int i = 0; i < CBNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollWidth;
        imageView.height = scrollHeight;
        imageView.y = 0;
        imageView.x = i * scrollWidth;
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i+1];
        imageView.image = [UIImage imageNamed:imageName];
        
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageview 就往里面添加其他内容
        if (i == CBNewFeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
#warning 默认情况下创建的scrollView里面可能会存在一些系统自带的子控件
    
    // 设置scrollView其他属性
    // 如果想要某个方向上不能滚动，这个方向上的数值传0即可
    scrollView.contentSize = CGSizeMake(CBNewFeatureCount * scrollWidth, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;

    
    // 添加pagecontrol 分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = CBNewFeatureCount;

    pageControl.centerX = scrollWidth * 0.5;
    pageControl.centerY = scrollHeight - 50;
    
    pageControl.pageIndicatorTintColor = [[UIColor alloc] initWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1.0];
    pageControl.currentPageIndicatorTintColor = [[UIColor alloc] initWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0];
    
    self.pageControl = pageControl;
    
    [self.view addSubview:pageControl];
    
    /**
     *  UIPageControl就算没有设置尺寸，其中的内容也会照常显示出来
     */
    //    pageControl.width = 100;
    //    pageControl.height = 50;
    //    pageControl.userInteractionEnabled = NO;
    
    
}

#pragma mark - 监听scrollview的滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.width;
    
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
}

/**
 *  向最后一个imageview里面添加内容
 *
 */
- (void)setupLastImageView:(UIImageView *)imageView {
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    // 分享给大家
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    shareButton.width = 120;
    shareButton.height = 30;
    shareButton.centerX = imageView.width * 0.5;
    shareButton.centerY = imageView.height * 0.64;
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [imageView addSubview:shareButton];
    
    // 开始微博
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = shareButton.centerX;
    startButton.centerY = imageView.height * 0.71;
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];

}



/**
 *  分享按钮shareButton的点击事件监听回调
 */
- (void)shareButtonClick:(UIButton *)shareButton {
    shareButton.selected = !shareButton.isSelected;
}

/**
 *  开始按钮startButton的点击事件监听回调
 */
- (void)startButtonClick {
    // 切换到tabbarcontroller
    /**
     *  三种方式
        1.push：依赖于UINavigationController，push操作可逆
        2.modal：控制器的切换可逆
        3.切换window的rootViewController
     */
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[CBTabBarController alloc] init];
}
@end


