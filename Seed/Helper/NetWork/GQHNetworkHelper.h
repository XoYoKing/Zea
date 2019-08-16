//
//  GQHNetworkHelper.h
//
//  Created by GuanQinghao on 2019-05-08.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


@class AFHTTPSessionManager,GQHNetworkResult;

/**
 网络请求结果回调

 @param result 网络请求结果
 */
typedef void(^GQHNetworkRequestHandler)(GQHNetworkResult *result);

/**
 自定义封装网络请求
 */
@interface GQHNetworkHelper : NSObject

/**
 自定义网络请求管理单例
 
 @return 网络请求管理单例
 */
+ (AFHTTPSessionManager *)qh_sharedManager;

#pragma mark - 鉴权网络请求
/**
 自定义封装GET鉴权网络请求

 @param auth 网络鉴权
 @param URLString 请求URL
 @param parameters 请求参数
 @param progress 请求进度
 @param handler 请求结果回调
 */
+ (void)qh_authRequestGET:(NSString *)auth URL:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nullable))progress handler:(GQHNetworkRequestHandler)handler;

/**
 自定义封装POST鉴权网络请求

 @param auth 网络鉴权
 @param URLString 请求URL
 @param parameters 请求参数
 @param progress 请求进度
 @param handler 请求结果回调
 */
+ (void)qh_authRequestPOST:(NSString *)auth URL:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))progress handler:(GQHNetworkRequestHandler)handler;

/**
 自定义封装PUT鉴权网络请求

 @param auth 网络鉴权
 @param URLString 请求URL
 @param parameters 请求参数
 @param handler 请求结果回调
 */
+ (void)qh_authRequestPUT:(NSString *)auth URL:(NSString *)URLString parameters:(id)parameters handler:(GQHNetworkRequestHandler)handler;

/**
 自定义封装DELETE鉴权网络请求

 @param auth 网络鉴权
 @param URLString 请求URL
 @param parameters 请求参数
 @param handler 请求结果回调
 */
+ (void)qh_authRequestDELETE:(NSString *)auth URL:(NSString *)URLString parameters:(id)parameters handler:(GQHNetworkRequestHandler)handler;

#pragma mark - 公共网络请求
/**
 自定义封装GET公共网络请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param progress 请求进度
 @param handler 请求结果回调
 */
+ (void)qh_requestGET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))progress handler:(GQHNetworkRequestHandler)handler;

/**
 自定义封装POST公共网络请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param progress 请求进度
 @param handler 请求结果回调
 */
+ (void)qh_requestPOST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))progress handler:(GQHNetworkRequestHandler)handler;

/**
 自定义封装PUT公共网络请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param handler 请求结果回调
 */
+ (void)qh_requestPUT:(NSString *)URLString parameters:(id)parameters handler:(GQHNetworkRequestHandler)handler;

/**
 自定义封装DELETE公共网络请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param handler 请求结果回调
 */
+ (void)qh_requestDELETE:(NSString *)URLString parameters:(id)parameters handler:(GQHNetworkRequestHandler)handler;

#pragma mark - 多图上传
/**
 多图上传

 @param auth 网络鉴权
 @param pictures 上传的图片数组
 @param URLString 上传URL
 @param parameters 请求参数
 @param progress 上传进度
 @param handler 请求结果回调
 */
+ (void)qh_authUpload:(NSString *)auth pictures:(NSArray *)pictures URL:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))progress handler:(GQHNetworkRequestHandler)handler;

@end
