//
//  GQHAppVersionModel.h
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>
 */
@interface GQHAppVersionModel : GQHBaseModel <NSSecureCoding>

/**
 ID
 */
@property (nonatomic, copy) NSString *qh_id;

/**
 模型类
 */
//@property (nonatomic, strong) NSArray<GQHBookModel *> *qh_books;


#pragma mark -
/**
 增-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_createAppVersionWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 查-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_readAppVersionWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 改-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_updateAppVersionWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 删-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_deleteAppVersionWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 列表-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_fetchAppVersionsWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

@end

NS_ASSUME_NONNULL_END
