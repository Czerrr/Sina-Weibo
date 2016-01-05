//
//  CBNavigationController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/26.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBNavigationController.h"
//#import "UIView+CBExtension.h"
//#import "UIBarButtonItem+CBExtension.h"

@interface CBNavigationController ()

@end

@implementation CBNavigationController

+ (void)initialize {
    // 设置全局navigation控制器的barbuttonitem（文字大小，颜色等）
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    
    // 普通状态
    NSMutableDictionary *mTextAttrs = [NSMutableDictionary dictionary];
    mTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    mTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    [item setTitleTextAttributes:mTextAttrs forState:UIControlStateNormal];
    
    
    // 不可用状态
    NSMutableDictionary *mDisableTextAttrs = [NSMutableDictionary dictionary];
    mDisableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];

    mDisableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    

    [item setTitleTextAttributes:mDisableTextAttrs forState:UIControlStateDisabled];

}



- (void)viewDidLoad {
    [super viewDidLoad];
}


/**
 *  重写push方法，拦截每个push进来的viewcontroller，进而设置他们的左右buttonitem
 *
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // navigation的根控制器（即messageVC）界面不该显示left right barbuttonitem
    if (self.viewControllers.count > 0) { 
        // 隐藏push进去的vc的tabbar
        viewController.hidesBottomBarWhenPushed = YES;

/*
        // 自定义leftbarbuttonitem
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置button图片
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置button尺寸 用到了自定义的uiview category
        backBtn.size = backBtn.currentBackgroundImage.size;
        
        // 监听button点击事件
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        
        
        // 同上，设置rightbarbuttonitem
        
        // rightbarbuttonitem
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        
        moreBtn.size = moreBtn.currentBackgroundImage.size;
        
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
 */
        
// 以下函数是上述注释的封装 调用UIBarButtonItem category的方法创建自定义UIBarButtonItem，并设置给left right按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_back"] highLightedImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] addTarget:self action:@selector(back)];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_more"] highLightedImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] addTarget:self action:@selector(more)];
        
    }
    
    [super pushViewController:viewController animated:YES];
    
}



/**
 *  左buttonitem点击事件回调 返回上一个vc
 */
- (void)back {
    [self popViewControllerAnimated:YES];
}

/**
 *  右buttonitem点击事件回调 返回根控制器
 */
- (void)more {
    [self popToRootViewControllerAnimated:YES];
}

@end
