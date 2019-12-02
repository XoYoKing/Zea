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


@interface GQHDatabaseManager ()

/**
 文件管理器
 */
@property (nonatomic, strong) NSFileManager *fileManager;

/**
 数据库队列
 */
@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

/**
 数据表名
 */
@property (nonatomic, strong) NSString *tableName;

@end

static GQHDatabaseManager *manager = nil;

@implementation GQHDatabaseManager

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

//MARK:数据库操作
/// 创建数据库文件
/// @param databaseName 数据库文件名
/// @param path 数据库文件路径
- (BOOL)qh_createDatabase:(NSString *)databaseName atPath:(NSString *)path {
    
    if (databaseName && databaseName.length > 0) {
        
        // 数据库文件全路径
        NSString *databasePath = [path stringByAppendingPathComponent:databaseName];
        
        if (![self.fileManager fileExistsAtPath:databasePath]) {
            
            // 创建数据库文件
            return [self.fileManager createFileAtPath:databasePath contents:nil attributes:nil];
        }
    }
    
    return NO;
}

/// 删除数据库文件(不能删除非空数据库)
/// @param databaseName 数据库文件名
/// @param path 数据库文件路径
- (BOOL)qh_removeDatabase:(NSString *)databaseName atPath:(NSString *)path {
    
    if (databaseName && databaseName.length > 0) {
        
        // 数据库文件全路径
        NSString *databasePath = [path stringByAppendingPathComponent:databaseName];
        
        if ([self.fileManager fileExistsAtPath:databasePath]) {
            
            // 数据库队列
            self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
            // 数据表名
            __block NSString *tableNames = @"";
            
            if (self.databaseQueue) {
                
                [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
                    
                    FMResultSet *resultSet = [db executeQuery: [self sql_queryAllTableName]];
                    
                    while ([resultSet next]) {
                        
                        [[resultSet resultDictionary] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                            
                            tableNames = [tableNames stringByAppendingFormat:@" %@", obj];
                        }];
                    }
                }];
                
                if (tableNames.length > 0) {
                    
                    NSLog(@"table name:%@",tableNames);
                    
                    return NO;
                }
            }
            
            return [self.fileManager removeItemAtPath:databasePath error:nil];
        }
    }
    
    return NO;
}

/// 数据库文件路径(已存在的数据库,不存在则返回nil)
/// @param databaseName 数据库文件名
- (NSString *)qh_pathOfDatabase:(NSString *)databaseName {
    
    
    
    
    
    
    
    
    
    return nil;
}

/// 遍历路径, 找到文件名
/// @param path 路径
- (void)retrieveFileName:(NSString *)fileName atPath:(NSString *)path {
    
    // 是否是文件夹目录
    BOOL isDirectory = false;
    // 是否存在
    BOOL isExist = [self.fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (isExist) {
        
        if (isDirectory) {
            
            // 文件夹下的所有文件及文件夹
            NSArray *directoryArray = [self.fileManager contentsOfDirectoryAtPath:path error:nil];
            
            for (NSString *name in directoryArray) {
                
                // 忽略隐藏的文件或文件夹
                if ([name hasPrefix:@"."]) {
                    
                    continue;
                }
                
                // 递归遍历
                [self retrieveFileName:fileName atPath:[path stringByAppendingPathComponent:name]];
            }
        } else {
            
            NSArray<NSString *> *components = [path componentsSeparatedByString:@"/"];
            if ([[components lastObject] isEqualToString:fileName]) {
                
            }
        }
    } else {
        
        NSLog(@"file not exist!");
    }
}











//MARK:数据表操作
/// 创建数据表
/// @param databaseName 数据库文件名
/// @param tableName 数据表名
/// @param cls 数据表对应的模型类
/// @param primary 主键名(单主键)
- (BOOL)qh_createTableInDatabase:(NSString *)databaseName withTableName:(NSString *)tableName model:(Class)cls primary:(NSString *)primary {
    
}

/// 清空数据库中的数据表
/// @param tableName 数据表名
/// @param databaseName 数据库文件名
- (BOOL)qh_truncateTable:(NSString *)tableName inDatabase:(NSString *)databaseName {
    
}

/// 删除数据库中的数据表
/// @param tableName 数据表名
/// @param databaseName 数据库文件名
- (BOOL)qh_dropTable:(NSString *)tableName inDatabase:(NSString *)databaseName {
    
}

//MARK:CRUD
/// 插入数据
/// @param model 数据模型
/// @param tableName 数据表名
/// @param databaseName 数据库文件名
- (BOOL)qh_insertData:(id)model inTable:(NSString *)tableName database:(NSString *)databaseName {
    
}

/// 查询指定属性指定值的数据
/// @param cls 数据表对应的模型类
/// @param key 指定属性
/// @param value 指定值
/// @param tableName 数据表名
/// @param databaseName 数据库文件名
- (NSArray *)qh_queryData:(Class)cls withKey:(NSString *)key value:(NSString *)value inTable:(NSString *)tableName database:(NSString *)databaseName {
    
}

/// 查询数据表中的所有数据
/// @param cls 数据表对应的模型类
/// @param tableName 数据表名
/// @param databaseName 数据库文件名
- (NSArray *)qh_queryAllWithClass:(Class)cls inTable:(NSString *)tableName database:(NSString *)databaseName {
    
}

/// 删除指定属性指定值的数据
/// @param cls 数据表对应的模型类
/// @param key 指定属性
/// @param value 指定值
/// @param tableName 数据表名
/// @param databaseName 数据库文件名
- (NSArray *)qh_deleteData:(Class)cls withKey:(NSString *)key value:(NSString *)value inTable:(NSString *)tableName database:(NSString *)databaseName {
    
}




//MARK:SQLite

/// 查询所有数据表名
- (NSString *)sql_queryAllTableName {
    
    return @"SELECT name FROM sqlite_master WHERE type = 'table' ORDER BY name;";
}



/// SQL语句-创建数据表
/// @param tableName 数据表名
- (NSString *)sql_createTable:(NSString *)tableName {
    
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 'json' TEXT)",table];
}


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











//MARK:Setter/Getter
- (NSFileManager *)fileManager {
    
    return [NSFileManager defaultManager];
}




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
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
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
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 数据表名称
    self.tableName = [[path componentsSeparatedByString:@"/"] lastObject];
    
    NSMutableArray *result = [NSMutableArray array];
    
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
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
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    // 数据表名称
    self.tableName = [[path componentsSeparatedByString:@"/"] lastObject];
    
    __block BOOL result;
    
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            if ([db tableExists:self.tableName]) {
                
                result = [db executeUpdate:[self sql_dropTable:self.tableName]];
            }
        }
        
        [db close];
    }];
    
    return result;
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
