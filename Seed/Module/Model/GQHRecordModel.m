//
//  GQHRecordModel.m
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHRecordModel.h"
#import "GQHHeader.h"
#import <FMDB/FMDB.h>


/// 本地数据库文件名
static NSString * const kFileName = @"db.sqlite";
/// 本地数据表文件名
static NSString * const kTableName = @"p_record";

@implementation GQHRecordModel

/**
 初始化Mock数据
 
 @return Mock数据
 */
- (instancetype)init {
    
    if (self = [super init]) {
        
        // mock
        
    }
    return self;
}

/**
 模型字段映射
 
 @return 模型字段映射字典
 */
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{
             
             @"qh_id" : @[@"id",@"iD",@"Id"],
             };
}

/**
 模型类映射
 
 @return 模型类映射字典
 */
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             
//             @"qh_books" : GQHBookModel.class,
             };
}


/**
 获取本地文件保存路径
 
 @param file 文件名
 @return 本地文件保存路径
 */
+ (NSString *)filePathWith:(NSString * _Nonnull )file {
    
    // 文件夹路径
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return [NSString stringWithFormat:@"%@/%@", filePath, file];
}

/**
 编码解档
 
 @param aDecoder 编码器
 @return 自定义对象
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.qh_id = [aDecoder decodeObjectForKey:@"qh_id"];
    }
    
    return self;
}

/**
 编码归档
 
 @param aCoder 编码器
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.qh_id forKey:@"qh_id"];
}

/**
 安全编码
 
 @return 是否支持
 */
+ (BOOL)supportsSecureCoding {
    
    return YES;
}

#pragma mark -
/**
 增-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_createRecordWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 查-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_readRecordWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 改-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_updateRecordWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 删-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_deleteRecordWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 列表-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_fetchRecordsWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}




//MARK: PublicMethod

/// 插入数据
/// @param record 模型数据
+ (BOOL)qh_insertRecord:(GQHRecordModel *)record {
    
    // 数据库文件路径
    NSString *filePath = [self filePathWith:kFileName];
    // 数据库队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:filePath];

    __block BOOL result;
    
    // 数据表操作
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            // 设置缓存, 提高查询效率
            [db setShouldCacheStatements:YES];
            
            if ([db tableExists:kTableName]) {
                
                result = [db executeUpdate:[self sql_insertRecord:record table:kTableName]];
            } else {
                
                // 表不存在, 创建表
                if ([db executeUpdate:[self sql_createTable:kTableName]]) {
                    
                   result = [db executeUpdate:[self sql_insertRecord:record table:kTableName]];
                }
            }
        }
        
        [db close];
    }];
    
    return result;
}

/// 查询所有记录
+ (NSArray<GQHRecordModel *> *)qh_fetchAllRecords {
    
    // 数据库文件路径
    NSString *filePath = [self filePathWith:kFileName];
    // 数据库队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
    NSMutableArray *result = [NSMutableArray array];
    
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            if ([db tableExists:kTableName]) {
                
                FMResultSet *resultSet = [db executeQuery:[self sql_queryRecords:kTableName]];
                
                while ([resultSet next]) {
                    
                    __block GQHRecordModel *model = [[GQHRecordModel alloc] init];
                    
                    [[resultSet resultDictionary] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                        if ([key isEqualToString:@"p_record_id"]) {
                            
                            model.qh_id = obj;
                        } else if ([key isEqualToString:@"p_record_level_order"]) {
                            
                            model.qh_levelOrder = [obj integerValue];
                        } else if ([key isEqualToString:@"p_record_level_title"]) {
                            
                            model.qh_levelTitle = obj;
                        } else if ([key isEqualToString:@"p_record_image"]) {
                            
                            model.qh_gameImage = obj;
                        } else if ([key isEqualToString:@"p_record_time"]) {
                            
                            model.qh_gameTime = [obj integerValue];
                        } else if ([key isEqualToString:@"p_record_count"]) {
                            
                            model.qh_gameCount = [obj integerValue];
                        } else if ([key isEqualToString:@"p_record_timestamp"]) {
                            
                            model.qh_timestamp = [obj doubleValue];
                        }
                    }];
                    
                    if (model.qh_id) {
                        
                        [result addObject:model];
                    }
                }
            }
        }
        
        [db close];
    }];
    
    return [result copy];
}

/// 删除数据表
+ (BOOL)qh_removeTable {
    
    // 数据库文件路径
    NSString *filePath = [self filePathWith:kFileName];
    // 数据库队列
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    
    __block BOOL result;
    
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            if ([db tableExists:kTableName]) {
                
                result = [db executeUpdate:[self sql_dropTable:kTableName]];
            }
        }
        
        [db close];
    }];
    
    return result;
}

//MARK: PrivateMethod
/// 创建数据表
/// @param table 数据表名称
+ (NSString *)sql_createTable:(NSString *)table {
    
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ( 'p_record_id' TEXT PRIMARY KEY NOT NULL UNIQUE, 'p_record_level_order' TEXT, 'p_record_level_title' TEXT, 'p_record_image' TEXT, 'p_record_time' TEXT, 'p_record_count' TEXT, 'p_record_timestamp' TEXT );",table];
}

/// 插入一条数据
/// @param record 模型数据
/// @param table 数据表名称
+ (NSString *)sql_insertRecord:(GQHRecordModel *)record table:(NSString *)table {
    
    // 先查所有数据，找到最大id
    NSArray<GQHRecordModel *> *records = [self qh_fetchAllRecords];
    __block NSInteger max_id = 0;
    
    [records enumerateObjectsUsingBlock:^(GQHRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (max_id < [obj.qh_id integerValue]) {
            
            max_id = [obj.qh_id integerValue];
        }
    }];
    
    //TODO:映射
    NSString *p_record_id = [NSString stringWithFormat:@"%ld",++max_id];
    NSString *p_record_level_order = [NSString stringWithFormat:@"%ld",record.qh_levelOrder];
    NSString *p_record_level_title = record.qh_levelTitle;
    NSString *p_record_gameImage = record.qh_gameImage;
    NSString *p_record_gameTime = [NSString stringWithFormat:@"%ld",record.qh_gameTime];
    NSString *p_record_gameCount = [NSString stringWithFormat:@"%ld",record.qh_gameCount];
    NSString *p_record_timestamp = [NSString stringWithFormat:@"%f",record.qh_timestamp];
    
    return [NSString stringWithFormat:@"INSERT INTO '%@' VALUES ('%@', '%@', '%@', '%@', '%@', '%@' , '%@');", table, p_record_id, p_record_level_order, p_record_level_title, p_record_gameImage, p_record_gameTime, p_record_gameCount, p_record_timestamp];
}

/// 查询所有数据
/// @param table 数据表名称
+ (NSString *)sql_queryRecords:(NSString *)table {
    
    return [NSString stringWithFormat:@"SELECT * FROM '%@'",table];
}

/// 删除数据表
/// @param table 数据表名称
+ (NSString *)sql_dropTable:(NSString *)table {
    
    return [NSString stringWithFormat:@"DROP TABLE '%@'", table];
}

#pragma mark - Setter

#pragma mark - Getter

@end


