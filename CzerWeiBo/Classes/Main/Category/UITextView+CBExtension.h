//
//  UITextView+CBExtension.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/13.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (CBExtension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;
@end
