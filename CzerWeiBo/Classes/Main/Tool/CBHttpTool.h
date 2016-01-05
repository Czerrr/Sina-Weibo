//
//  CBHttpTool.h
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/15.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

// 网络工具类，封装了AFN的方法
#import <Foundation/Foundation.h>


@interface CBHttpTool : NSObject

/** get方法 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

/** post方法 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;



@end
