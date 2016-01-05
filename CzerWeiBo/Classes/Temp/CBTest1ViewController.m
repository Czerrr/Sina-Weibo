//
//  CBTest1ViewController.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/26.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBTest1ViewController.h"
#import "CBTest2ViewController.h"
@interface CBTest1ViewController ()

@end

@implementation CBTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CBTest2ViewController *test2 = [[CBTest2ViewController alloc] init];
    test2.title = @"test2";
    [self.navigationController pushViewController:test2 animated:YES];
}



@end
