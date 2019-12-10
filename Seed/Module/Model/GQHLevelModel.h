//
//  GQHLevelModel.h
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>
 */
@interface GQHLevelModel : GQHBaseModel

/**
 SQLite数据表的主键(固定)
 */
@property (nonatomic, copy) NSString *db_pk_id;

/**
 后台业务id
 */
@property (nonatomic, copy) NSString *qh_id;

/**
 等级标题
 */
@property (nonatomic, copy) NSString *qh_title;

/**
 等级阶数
 */
@property (nonatomic, copy) NSString *qh_order;

/**
 等级描述
 */
@property (nonatomic, copy) NSString *qh_detail;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL qh_mark;

/// 查询等级
+ (NSArray<GQHLevelModel *> *)qh_allLevels;

@end

NS_ASSUME_NONNULL_END
