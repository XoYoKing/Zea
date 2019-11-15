//
//  GQHHelpModel.h
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>
 */
@interface GQHHelpModel : GQHBaseModel <NSSecureCoding>

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
+ (void)qh_createHelpWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 查-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_readHelpWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 改-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_updateHelpWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 删-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_deleteHelpWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

/**
 列表-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_fetchHelpsWithParameters:(nullable id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler;

@end

NS_ASSUME_NONNULL_END
