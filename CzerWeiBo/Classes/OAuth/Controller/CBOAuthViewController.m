//
//  CBOAuthViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/29.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBOAuthViewController.h"
#import "CBAccountTool.h"
#import "CBHttpTool.h"

@interface CBOAuthViewController () <UIWebViewDelegate>

@end

@implementation CBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    webView.delegate = self;
    
    // 用webview加载登录页面（新浪提供的）
    // 请求地址和请求参数都放在url里面
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3988965781&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - 代理方法


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 截取请求微博授权后的回调地址，从而获得地址中的code
    
    // 获得url
    NSString *url = request.URL.absoluteString;
//    CBLog(@"shouldStartLoadWithRequest%@", url);
    
    // 判断url是否是回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = (int)(range.location + range.length);
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accesstoken
        [self accesstTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
    return YES;
}

/**
 *  利用code换取一个accessToken 由新浪提供的接口文档
 *
 */
- (void) accesstTokenWithCode:(NSString *)code {
    
    // 默认的responseSerializer中没有text/plain类型，需要在AFN源代码中增加
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3988965781";
    params[@"client_secret"] = @"60e81c61dd73b273cc5c88da3c8bcbd2";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    
    [CBHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        
        // 将返回的账号字典数据转换成模型 存入沙盒
        CBAccount *account = [CBAccount accountWithDict:json];
        
        // 存储账号信息
        [CBAccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        

    } failure:^(NSError *error) {
        CBLog(@"request failed...%@", error);

    }];
    
}

@end





