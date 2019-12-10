//
//  GQHMenuModel.h
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>
 */
@interface GQHMenuModel : GQHBaseModel

/**
 SQLite数据表的主键(固定)
 */
@property (nonatomic, copy) NSString *db_pk_id;

/**
 后台业务id
 */
@property (nonatomic, copy) NSString *qh_id;

/**
 标题
 */
@property (nonatomic, copy) NSString *qh_title;

/**
 图标
 */
@property (nonatomic, copy) NSString *qh_icon;

/// 首页菜单
+ (NSArray<GQHMenuModel *> *)qh_allMenus;

@end

NS_ASSUME_NONNULL_END
