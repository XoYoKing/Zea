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
@interface GQHLevelModel : GQHBaseModel <NSSecureCoding>

/**
 ID
 */
@property (nonatomic, copy) NSString *qh_id;

/**
 等级标题
 */
@property (nonatomic, strong) NSString *qh_title;

/**
 等级阶数
 */
@property (nonatomic, assign) NSInteger qh_order;

/**
 等级描述
 */
@property (nonatomic, strong) NSString *qh_detail;

//@[@{@"title":@"newbie",@"order":@"3",@"detail":@"新手入门级"}.mutableCopy,
//@{@"title":@"junior",@"order":@"4",@"detail":@"初级"}.mutableCopy,
//@{@"title":@"senior",@"order":@"5",@"detail":@"高级"}.mutableCopy,
//@{@"title":@"master",@"order":@"7",@"detail":@"大师级"}.mutableCopy,
//@{@"title":@"guru",@"order":@"9",@"detail":@"宗师级"}.mutableCopy,
//@{@"title":@"god",@"order":@"11",@"detail":@"惊为天人"}.mutableCopy].mutableCopy;


#pragma mark -
/**
 增-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_createLevelWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 查-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_readLevelWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 改-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_updateLevelWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 删-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_deleteLevelWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 列表-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_fetchLevelsWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

@end

NS_ASSUME_NONNULL_END
