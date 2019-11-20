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
 ID
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

#pragma mark -
/**
 增-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_createRecordWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 查-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_readRecordWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 改-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_updateRecordWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 删-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_deleteRecordWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 列表-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_fetchRecordsWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;


/// 插入数据
/// @param record 模型数据
+ (BOOL)qh_insertRecord:(GQHRecordModel *)record;

/// 查询所有记录
+ (NSArray<GQHRecordModel *> *)qh_fetchAllRecords;

/// 删除数据表
+ (BOOL)qh_removeTable;

@end

NS_ASSUME_NONNULL_END
