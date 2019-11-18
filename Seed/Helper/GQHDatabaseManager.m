//
//  GQHDatabaseManager.m
//  Seed
//
//  Created by Mac on 2019/11/18.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHDatabaseManager.h"
#import <FMDB/FMDB.h>
#import <objc/message.h>
#import <YYModel/YYModel.h>


@interface GQHDatabaseManager ()

/**
 数据库队列
 */
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

/**
 数据表名
 */
@property (nonatomic, strong) NSString *tableName;

@end

@implementation GQHDatabaseManager

static GQHDatabaseManager *manager = nil;

//MARK: PublicMethod

/// 插入数据
/// @param model 模型数据
/// @param path 数据表路径
- (BOOL)qh_insertDataWithModel:(id)model filePath:(NSString *)path {
    
    // 数据库队列
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 数据表名称
    self.tableName = [[path componentsSeparatedByString:@"/"] lastObject];
    
    __block BOOL result;
    
    // 数据表操作
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            // 设置缓存, 提高查询效率
            [db setShouldCacheStatements:YES];
            
            if ([db tableExists:self.tableName]) {
                
                // 模型转json后插入数据表
                NSString *json = [model yy_modelToJSONString];
                result = [db executeUpdate:[self sql_insertJSON:json table:self.tableName]];
            } else {
                
                // 表不存在, 创建表
                if ([db executeUpdate:[self sql_createTable:self.tableName]]) {
                    
                    // 模型转json后插入数据表
                    NSString *json = [model yy_modelToJSONString];
                    result = [db executeUpdate:[self sql_insertJSON:json table:self.tableName]];
                }
            }
        }
    }];
    
    return result;
}

/// 查询所有数据
/// @param cls 模型类
/// @param path 数据表路径
- (NSArray *)qh_fetchDataWithClass:(Class)cls filePath:(NSString *)path {
    
    // 数据库队列
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 数据表名称
    self.tableName = [[path componentsSeparatedByString:@"/"] lastObject];
    
    NSMutableArray *result = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            if ([db tableExists:self.tableName]) {
                
                FMResultSet *resultSet = [db executeQuery:[self sql_queryAllDataFrom:self.tableName]];
                
                while ([resultSet next]) {
                    
                    __block NSString *json = @"";
                    [[resultSet resultDictionary] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                        if ([key isEqualToString:@"json"]) {
                            
                            json = [NSString stringWithFormat:@"%@",obj];
                            
                            // json转模型
                            id model = [[cls class] yy_modelWithJSON:json];
                            [result addObject:model];
                        }
                    }];
                }
            }
        }
        
        [db close];
    }];
    
    return [result copy];
}

/// 删除表文件
/// @param path 数据表路径
- (BOOL)qh_removeDatabase:(NSString *)path {
    
    // 数据库队列
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 数据表名称
    self.tableName = [[path componentsSeparatedByString:@"/"] lastObject];
    
    __block BOOL result;
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            if ([db tableExists:self.tableName]) {
                
                result = [db executeUpdate:[self sql_dropTable:self.tableName]];
            }
        }
        
        [db close];
    }];
    
    return result;
}

/// 数据库管理单例
+ (instancetype)qh_sharedDatabaseManager {
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL] init];
    });
    
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return [[self class] qh_sharedDatabaseManager];
}

//MARK: PrivateMethod
/// 创建数据表
/// @param table 数据表名称
- (NSString *)sql_createTable:(NSString *)table {
    
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 'json' TEXT)",table];
}

/// 插入一条数据
/// @param json 数据
/// @param table 数据表名称
- (NSString *)sql_insertJSON:(NSString *)json table:(NSString *)table {
    
    return [NSString stringWithFormat:@"INSERT INTO '%@' (json) VALUES ('%@')", table, json];
}

//MARK:需要获取是哪一个？？
/// 更新指定数据
/// @param json 更新后的数据
/// @param index 指定索引(id)
/// @param table 数据表名称
- (NSString *)sql_updateJSON:(NSString *)json index:(NSInteger)index table:(NSString *)table {
    
    return [NSString stringWithFormat:@"UPDATE '%@' SET JSON = '%@' WHERE ID = %ld;",table, json, index];
}

/// 查询所有数据
/// @param table 数据表名称
- (NSString *)sql_queryAllDataFrom:(NSString *)table {
    
    return [NSString stringWithFormat:@"SELECT * FROM '%@'",table];
}

/// 删除数据表
/// @param table 数据表名称
- (NSString *)sql_dropTable:(NSString *)table {
    
    return [NSString stringWithFormat:@"DROP TABLE '%@'", table];
}

@end
