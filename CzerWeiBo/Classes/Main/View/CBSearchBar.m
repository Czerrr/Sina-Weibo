//
//  CBSearchBar.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/10/27.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBSearchBar.h"

@implementation CBSearchBar

+ (instancetype)searchBar {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"Please enter...";
        self.font = [UIFont systemFontOfSize:15];
        
        // 这里图片在xcode里设置了拉升slicing属性
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 给searchBar添加放大镜图片
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        // 添加searchIcon到searchBar上
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;

    }
    return self;
}
@end
