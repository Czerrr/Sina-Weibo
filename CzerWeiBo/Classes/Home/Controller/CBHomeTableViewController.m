//
//  CBHomeTableViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/25.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBHomeTableViewController.h"
#import "CBDropdownMenu.h"
#import "CBHttpTool.h"
#import "CBAccountTool.h"
#import "CBTitleButton.h"
#import "UIImageView+WebCache.h"
#import "CBUser.h"
#import "CBStatus.h"
#import "CBLoadMoreFooter.h"
#import "CBStatusTableViewCell.h"
#import "CBStatusFrame.h"
#import "CBStatusTool.h"
#import "CBDropdownMenuTableViewController.h"

@interface CBHomeTableViewController () <CBDropdownMenuDelegate>

/**
 *  微博数组(里面放的是CBStatusFrame模型，一个模型代表一条微博)
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation CBHomeTableViewController

/**
 *  懒加载statusFrames属性
 *
 */
- (NSMutableArray *)statusFrames {
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 背景灰色
    self.tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(CBStatusCellBottomMargin, 0, 0, 0);
    
    // 设置导航栏内容
    [self setupNav];
    
    // 获得用户信息(昵称)
    [self setupUserInfo];

    
    // 集成下拉刷新控件
    [self setupDownRefresh];
    
    // 集成上拉刷新控件
    [self setupUpRefresh];

/*
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    //主线程也会抽时间处理一下timer
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
*/
    
}

/**
 *  获得未读数
 */
- (void)setupUnreadCount {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    CBAccount *account = [CBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [CBHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        // 微博的未读数 NSNumber --> NSString(description转)
        NSString *unreadCount = [json[@"status"] description];
        if ([unreadCount isEqualToString:@"0"]) { // 如果未读数是0，清空数字
            self.tabBarItem.badgeValue = nil;
            // 程序小图标右上角标识
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = unreadCount;
            // 程序小图标右上角标识
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount.intValue;
        }

    } failure:^(NSError *error) {
        CBLog(@"setupUnreadCount error...%@", error);

    }];
    
//    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        // 微博的未读数 NSNumber --> NSString(description转)
//        NSString *unreadCount = [responseObject[@"status"] description];
//        if ([unreadCount isEqualToString:@"0"]) { // 如果未读数是0，清空数字
//            self.tabBarItem.badgeValue = nil;
//            // 程序小图标右上角标识
//            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//        } else {
//            self.tabBarItem.badgeValue = unreadCount;
//            // 程序小图标右上角标识
//            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount.intValue;
//        }
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        CBLog(@"setupUnreadCount error...%@", error);
//    }];
}

/**
 *  集成上拉刷新控件
 */
- (void)setupUpRefresh {
    CBLoadMoreFooter *footer = [CBLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

/**
 *  集成下拉刷新控件
 */
- (void)setupDownRefresh {
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    // 1.只有用户通过手动下拉刷新，才会触动UIControlEventValueChanged事件
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:control];
    
    // 2.马上进入刷新状态（仅仅显示，并不会触发UIControlEventValueChanged事件）
    [control beginRefreshing];
    
    // 3.马上加载数据
    [self refreshStateChange:control];
}

/**
 *  进入刷新状态，加载最新数据
 */
- (void)refreshStateChange:(UIRefreshControl *)control {
    // 1.创建请求管理者
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    CBAccount *account = [CBAccountTool account];
    params[@"access_token"] = account.access_token;
    
    // 取出当前数组模型中最前面的模型数据，即当前所有微博中最新微博
    CBStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    if (firstStatusFrame) {
        // 若指定此参数，会返回id比since_id大的微博（即最新微博），默认为0
        params[@"since_id"] = firstStatusFrame.status.idstr;
    }
    
    // 2.尝试先从数据库中加载微博数据
    NSArray *dictArray = [CBStatusTool statusesWithParams:params];
    if (dictArray.count) { // 数据库有缓存数据
        // 从微博的字典数组中取出每条字典转换成status模型
        NSMutableArray *newStatusFrameArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            CBStatus *status = [CBStatus statusWithDict:dict];
            CBStatusFrame *statusFrame = [[CBStatusFrame alloc] init];
            statusFrame.status = status;
            // 将每个statusFrame模型添加到临时的模型数组中
            [newStatusFrameArray addObject:statusFrame];
        }
        // 将临时模型数组内容添加到模型数组属性最前面（self.statusFrames）
        NSRange range = NSMakeRange(0, newStatusFrameArray.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatusFrameArray atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [control endRefreshing];
        
        // 显示最新微博的数量
        [self showNewStatusCount:newStatusFrameArray.count];
    } else {
        // 3.发送请求
        [CBHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
            // 将服务器返回的数据存储到沙盒数据库中
            [CBStatusTool saveStatuses:json[@"statuses"]];
            
            // 取得微博的字典数组
            NSArray *dictArray = json[@"statuses"];
            //        CBLog(@"%@", responseObject);
            
            // 从微博的字典数组中取出每条字典转换成status模型
            NSMutableArray *newStatusFrameArray = [NSMutableArray array];
            for (NSDictionary *dict in dictArray) {
                CBStatus *status = [CBStatus statusWithDict:dict];
                CBStatusFrame *statusFrame = [[CBStatusFrame alloc] init];
                statusFrame.status = status;
                // 将每个statusFrame模型添加到临时的模型数组中
                [newStatusFrameArray addObject:statusFrame];
            }
            // 将临时模型数组内容添加到模型数组属性最前面（self.statusFrames）
            NSRange range = NSMakeRange(0, newStatusFrameArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.statusFrames insertObjects:newStatusFrameArray atIndexes:indexSet];
            
            // 刷新表格
            [self.tableView reloadData];
            
            // 结束刷新
            [control endRefreshing];
            
            // 显示最新微博的数量
            [self showNewStatusCount:newStatusFrameArray.count];
            
        } failure:^(NSError *error) {
            CBLog(@"refreshStateChange error.....%@", error);
            // 结束刷新
            [control endRefreshing];
        }];

    }

    
//    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        // 取得微博的字典数组
//        NSArray *dictArray = responseObject[@"statuses"];
//
//        // 从微博的字典数组中取出每条字典转换成status模型
//        NSMutableArray *newStatusFrameArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            CBStatus *status = [CBStatus statusWithDict:dict];
//            CBStatusFrame *statusFrame = [[CBStatusFrame alloc] init];
//            statusFrame.status = status;
//            // 将每个statusFrame模型添加到临时的模型数组中
//            [newStatusFrameArray addObject:statusFrame];
//        }
//        // 将临时模型数组内容添加到模型数组属性最前面（self.statusFrames）
//        NSRange range = NSMakeRange(0, newStatusFrameArray.count);
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrames insertObjects:newStatusFrameArray atIndexes:indexSet];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
//        // 结束刷新
//        [control endRefreshing];
//        
//        // 显示最新微博的数量
//        [self showNewStatusCount:newStatusFrameArray.count];
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        CBLog(@"refreshStateChange error.....%@", error);
//        // 结束刷新
//        [control endRefreshing];
//    }];
//
}

/**
 *  显示最新微博的数量
 *
 */
- (void)showNewStatusCount:(NSUInteger)count {
    // 刷新成功（清空图标数字）
    self.tabBarItem.badgeValue = nil;
    
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，请稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    // 3.添加
    label.y = 64 - label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    CGFloat duration = 1.0; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);// 用transform来做动画
    } completion:^(BOOL finished) {
        // 延迟执行下一个动画
        CGFloat delay = 1.0; // 延迟
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}



/**
 *  加载更多微博数据
 */
- (void)loadMoreStatus {
    // 1.创建请求管理者
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    CBAccount *account = [CBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出数组中最后面的微博（即当前数据中最旧的一条微博）
    CBStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    CBStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        long long max_id = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(max_id);
    }
    
    // 先从数据库中加载缓存数据
    NSArray *dictArray = [CBStatusTool statusesWithParams:params];
    if (dictArray.count) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            CBStatus *status = [CBStatus statusWithDict:dict];
            CBStatusFrame *statusFrame = [[CBStatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
        
    } else {
        // 3.发送请求
        [CBHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
            // 将服务器返回的数据存储到沙盒数据库中
            [CBStatusTool saveStatuses:json[@"statuses"]];
            
            NSArray *dictArray = json[@"statuses"];
            NSMutableArray *statusFrameArray = [NSMutableArray array];
            for (NSDictionary *dict in dictArray) {
                CBStatus *status = [CBStatus statusWithDict:dict];
                CBStatusFrame *statusFrame = [[CBStatusFrame alloc] init];
                statusFrame.status = status;
                [statusFrameArray addObject:statusFrame];
            }
            [self.statusFrames addObjectsFromArray:statusFrameArray];
            // 刷新表格
            [self.tableView reloadData];
            // 结束刷新
            self.tableView.tableFooterView.hidden = YES;
        } failure:^(NSError *error) {
            CBLog(@"loadMoreStatus error...%@", error);
            // 结束刷新(隐藏footerview)
            self.tableView.tableFooterView.hidden = YES;
        }];

    }
    
    
//    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSArray *dictArray = responseObject[@"statuses"];
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            CBStatus *status = [CBStatus statusWithDict:dict];
//            CBStatusFrame *statusFrame = [[CBStatusFrame alloc] init];
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        [self.statusFrames addObjectsFromArray:statusFrameArray];
//        // 刷新表格
//        [self.tableView reloadData];
//        // 结束刷新
//        self.tableView.tableFooterView.hidden = YES;
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        CBLog(@"loadMoreStatus error...%@", error);
//        // 结束刷新(隐藏footerview)
//        self.tableView.tableFooterView.hidden = YES;
//    }];
}

/**
 *  获得用户信息(昵称)
 */
- (void)setupUserInfo {

    // https://api.weibo.com/2/users/show.json
    // 发送获取用户信息的请求
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    CBAccount *account = [CBAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [CBHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        //  标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 取出用户昵称
        CBUser *user = [CBUser userWithDict:json];
        
        // 设置昵称到titleButton按钮上
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        account.name = user.name;
        [CBAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        CBLog(@"setupUserInfo error...%@", error);
    }];
    
//    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        //  标题按钮
//        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
//        // 取出用户昵称
//        CBUser *user = [CBUser userWithDict:responseObject];
//        
//        // 设置昵称到titleButton按钮上
//        [titleButton setTitle:user.name forState:UIControlStateNormal];
//        
//        // 存储昵称到沙盒中
//        account.name = user.name;
//        [CBAccountTool saveAccount:account];
//        
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        CBLog(@"setupUserInfo error...%@", error);
//    }];
}

/**
 *  设置导航栏内容
 */
- (void)setupNav {
    // 给首页左右上角添加UIBarButtonItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highLightedImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] addTarget:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highLightedImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] addTarget:self action:@selector(pop)];
    
    // 首页添加下拉菜单按钮
    CBTitleButton *titleButton = [[CBTitleButton alloc] init];

    // 设置按钮内容
    // 获取上一次的昵称
    NSString *name = [CBAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];

    // 设置按钮点击事件
    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;

}

/**
 *  titleButton点击事件回调
 */
- (void)titleButtonClicked:(UIButton *)titleButton {
    
    // 显示下拉菜单
    CBDropdownMenu *dropdownMenu = [CBDropdownMenu dropdownMenu];
    
    // 设置dropdownMenu的代理
    dropdownMenu.myDelegate = self;
    
    // 设置下拉菜单里的内容    
    CBDropdownMenuTableViewController *vc = [[CBDropdownMenuTableViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    vc.tableView.height = 400;
    vc.tableView.width = 200;
    
    dropdownMenu.contentController = vc;

    // 显示
    [dropdownMenu showFrom:titleButton];
    
}

/**
 *  leftBarButtonItem回调
 */
- (void)friendSearch {
    CBLog(@"friendSearch...");
}

/**
 *  rightBarButtonItem回调
 */
- (void)pop {
    CBLog(@"pop...");
}

#pragma mark - 代理方法
/**
 *  下拉菜单弹出框被销毁了
 *
 */
- (void)dropdownMenuDidDismiss:(CBDropdownMenu *)dropdownMenu {
    // 首页按钮旁的箭头图片向下
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;

}

/**
 *  下拉菜单弹出框被显示了
 *
 */
- (void)dropdownMenuDidShow:(CBDropdownMenu *)dropdownMenu {
    // 首页按钮旁的箭头图片向上
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获得自定义的cell
    CBStatusTableViewCell *cell = [CBStatusTableViewCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    // 如果没有数据，直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
        return;
    }
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    // 当最后一个cell完全进入视野内时
    if (offsetY >= judgeOffsetY) {
//        self.tableView.tableFooterView.backgroundColor = [UIColor greenColor];
        self.tableView.tableFooterView.hidden = NO;
        // 加载更多微博数据
        [self loadMoreStatus];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CBStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}


@end



