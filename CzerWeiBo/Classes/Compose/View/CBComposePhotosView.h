//
//  CBComposePhotosView.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/9.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBComposePhotosView : UIView
@property (nonatomic, strong, readonly) NSMutableArray *photos;
- (void)addPhoto:(UIImage *)photo;
@end
