//
//  GQHDatabaseManager.h
//  Seed
//
//  Created by Mac on 2019/11/18.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface GQHDatabaseManager : NSObject

/// 数据库管理单例
+ (instancetype)qh_sharedDatabaseManager;

/// 插入数据
/// @param model 模型数据
/// @param path 数据表路径
- (BOOL)qh_insertDataWithModel:(id)model filePath:(NSString *)path;

/// 查询所有数据
/// @param cls 模型类
/// @param path 数据表路径
- (NSArray *)qh_fetchDataWithClass:(Class)cls filePath:(NSString *)path;

/// 删除表文件
/// @param path 数据表路径
- (BOOL)qh_removeDatabase:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
