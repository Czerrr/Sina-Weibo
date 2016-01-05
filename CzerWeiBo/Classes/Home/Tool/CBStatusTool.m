//
//  CBStatusTool.m
//  CzerWeiBo
//
//  Created by Czer Bourne on 15/11/17.
//  Copyright © 2015年 Czerrr. All rights reserved.
//

#import "CBStatusTool.h"
#import "FMDB.h"
@implementation CBStatusTool

static FMDatabase *_db;

+(void)initialize {
    // 1.打开数据库
    // 沙盒路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
}

+ (NSArray *)statusesWithParams:(NSDictionary *)params {
    // 根据请求参数生成对应的查询sql语句
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", params[@"since_id"]];
    } else if (params[@"max_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;", params[@"max_id"]];
    } else {
        sql = @"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;";
    }
    
    // 查询
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:dict];
    }
    return statuses;
}

+ (void)saveStatuses:(NSArray *)statuses {
    
    // 要将一个对象存入数据库的blob字段，最好先转化为NSData
    for (NSDictionary *status in statuses) {
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status, idstr) VALUES (%@, %@);", statusData, status[@"idstr"]];
    }
}
@end
