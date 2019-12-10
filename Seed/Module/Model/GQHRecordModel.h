//
//  GQHRecordModel.h
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>
 */
@interface GQHRecordModel : GQHBaseModel <NSSecureCoding>

/**
 SQLite数据表的主键(固定)
 */
@property (nonatomic, copy) NSString *db_pk_id;

/**
 后台业务id
 */
@property (nonatomic, copy) NSString *qh_id;

/**
 游戏等级(阶数)
 */
@property (nonatomic, assign) NSInteger qh_levelOrder;

/**
 游戏等级(标题)
 */
@property (nonatomic, copy) NSString *qh_levelTitle;

/**
 游戏图片
 */
@property (nonatomic, copy) NSString *qh_gameImage;

/**
 游戏用时
 */
@property (nonatomic, assign) NSInteger qh_gameTime;

/**
 游戏计数
 */
@property (nonatomic, assign) NSInteger qh_gameCount;

/**
 游戏完成时间戳
 */
@property (nonatomic, assign) CGFloat qh_timestamp;

/// 插入数据
/// @param record 模型数据
+ (BOOL)qh_insertRecord:(GQHRecordModel *)record;

/// 查询所有记录
+ (NSArray<GQHRecordModel *> *)qh_fetchAllRecords;

/// 最优记录
+ (NSArray<GQHRecordModel *> *)qh_fetchBestRecords;

/// 删除数据表
+ (BOOL)qh_removeTable;

@end

NS_ASSUME_NONNULL_END
