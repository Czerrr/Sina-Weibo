//
//  CBComposeViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/8.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBComposeViewController.h"
#import "CBAccountTool.h"
#import "CBHttpTool.h"
#import "AFNetworking.h"
#import "CBComposeToolbar.h"
#import "CBComposePhotosView.h"
#import "CBEmotionKeyboard.h"
#import "CBEmotion.h"
#import "CBEmotionTextView.h"

@interface CBComposeViewController () <UITextViewDelegate, CBComposeToolbarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/** 输入框 */
@property (nonatomic, weak) CBEmotionTextView *textView;

/** 工具条 */
@property (nonatomic, weak) CBComposeToolbar *toolbar;

/** 相册（存放拍照或者相册中选择的图片） */
@property (nonatomic, weak) CBComposePhotosView *photosView;

/** 自定义表情键盘 */
@property (nonatomic, strong) CBEmotionKeyboard *emotionKeyboard;

/** 是否在切换键盘 */
@property (nonatomic, assign) BOOL isSwitchingKeyboard;
@end

@implementation CBComposeViewController

#pragma mark - 系统方法

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // 设置顶部导航栏
    [self setupNav];
    
    // 设置输入框
    [self setupTextView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加相册
    [self setupPhotosView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}


#pragma mark - 初始化方法

/**
 *  懒加载emotionKeyboard
 *
 */
- (CBEmotionKeyboard *)emotionKeyboard {
    if (!_emotionKeyboard) {
        _emotionKeyboard = [[CBEmotionKeyboard alloc] init];
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = 260;
    }
    return _emotionKeyboard;
}

/**
 *  添加相册
 */
- (void)setupPhotosView {
    CBComposePhotosView *photosView = [[CBComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    photosView.y = 100;
    self.photosView = photosView;
    [self.textView addSubview:photosView];
}

/**
 *  工具条
 */
- (void)setupToolbar {
    CBComposeToolbar *toolbar = [[CBComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.delegate = self;
    toolbar.y = self.view.height - toolbar.height;
    
    // inputAccessoryView设置显示在键盘顶部的内容
//    self.textView.inputAccessoryView = toolbar;
    
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 *  设置输入框
 */
- (void)setupTextView {
    // 在这个控制器中，textView的contentInset默认是64
    CBEmotionTextView *textView = [[CBEmotionTextView alloc] init];
    // 垂直方向上永远有弹簧效果
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 成为第一响应者(能输入文本的控件一旦成为第一响应者，就会弹出键盘)
    // 放在这里第一次弹出时界面会卡顿，放在willDidAppear中好
//    [textView becomeFirstResponder];
    
    // 监听文字改变通知，将右上角发送按钮设为可用
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 监听键盘弹出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:@"CBEmotionDidSelectNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteButtonDidClick) name:@"CBEmotionDidDeleteNotification" object:nil];
}


/**
 *  设置顶部导航栏
 */
- (void)setupNav {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor colorWithRed:246/255.0 green:233/255.0 blue:220/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    
    UILabel *titleView = [[UILabel alloc] init];
    titleView.width = 200;
    titleView.height = 44;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.numberOfLines = 0;
    
    // 用户名称
    NSString *name = [CBAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        
        // 创建一个带有属性的字符串（比如 颜色属性 文字属性等）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        // 添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }

}

#pragma mark - 监听方法

/**
 *  监听删除按钮的点击
 */
- (void)deleteButtonDidClick {
    [self.textView deleteBackward];
}

/**
 *  监听表情按钮的点击
 */
- (void)emotionDidSelect:(NSNotification *)notification {
    CBEmotion *emotion = notification.userInfo[@"selectEmotion"];
    
    [self.textView insertEmotion:emotion];
    
    
}

/**
 *  监听系统键盘尺寸变化(显示 隐藏等)
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    // 如果是在切换系统键盘和自定义表情键盘，CBComposeToolbar位置不随着键盘落下而落下
    if (self.isSwitchingKeyboard) {
        return;
    }
    
    // 通知里有一个userInfo的字典信息很重要
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        if (keyboardFrame.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardFrame.origin.y - self.toolbar.height;
        }
    }];
}

/**
 *  监听输入框有内容输入，设置发送按钮可用
 */
- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

/**
 *  左上角取消按钮
 */
- (void)cancel {
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  右上角发送按钮
 */
- (void)send {
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发布带有图片的微博
 */
- (void)sendWithImage {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CBAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    // 上传文件

    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"success" message:@"good" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"bad" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        CBLog(@"CBComposeViewController send error.....%@", error);
    }];
    

}

/**
 *  发布不带图片的微博
 */
- (void)sendWithoutImage {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CBAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    [CBHttpTool post:@"https://api.weibo.com/2/statuses/update.json" params:params success:^(id json) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"success" message:@"good" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"bad" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        CBLog(@"CBComposeViewController send error.....%@", error);
    }];
    
//    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"success" message:@"good" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert show];
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"bad" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        [alert show];
//        CBLog(@"CBComposeViewController send error.....%@", error);
//    }];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - CBComposeToolbarDelegate
- (void)composeToolbar:(CBComposeToolbar *)toolbar didClickButton:(CBComposeToolbarButtonType)buttonType {
    switch (buttonType) {
        case CBComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
            
        case CBComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
            
        case CBComposeToolbarButtonTypeMention:
            
            break;
            
        case CBComposeToolbarButtonTypeTrend:
            
            break;
            
        case CBComposeToolbarButtonTypeEmotion:
            // 切换表情键盘和系统自带普通键盘
            [self switchKeyboard];
            break;
            
        default:
            break;
    }
}

#pragma mark - 其它方法

/**
 *  切换键盘
 */
- (void)switchKeyboard {
    self.isSwitchingKeyboard = YES;
    
    if (self.textView.inputView == nil) { // 如果是系统自带键盘
        // 切换成表情键盘
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.isEmotionKeyboard = YES;
        
        // 工具条显示键盘图标
    } else { // 如果是表情键盘
        self.textView.inputView = nil;
        
        // 工具条显示表情图标
        self.toolbar.isEmotionKeyboard = NO;
    }
    
    // 退出旧的键盘
    [self.view endEditing:YES];
    
    self.isSwitchingKeyboard = NO;

    
    // 延迟执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 弹出新键盘
        [self.textView becomeFirstResponder];
    });
    

}

- (void)openCamera {
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum {
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = type;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerController代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // info中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 添加图片到photosView中
    [self.photosView addPhoto:image];
}

@end





