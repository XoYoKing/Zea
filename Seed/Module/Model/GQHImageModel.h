//
//  GQHImageModel.h
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>
 */
@interface GQHImageModel : GQHBaseModel

/**
 SQLite数据表的主键(固定)
 */
@property (nonatomic, copy) NSString *db_pk_id;

/**
 后台业务id
 */
@property (nonatomic, copy) NSString *qh_id;

/**
 图片分类名称
 */
@property (nonatomic, copy) NSString *qh_title;

/**
 图片(本地文件名称)
 */
@property (nonatomic, copy) NSString *qh_image;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL qh_mark;

/// 查询图片
+ (NSArray<GQHImageModel *> *)qh_fetchImageWithPage:(NSInteger)page;

@end

NS_ASSUME_NONNULL_END
