//
//  GQHNetworkResultModel.h
//
//  Created by GuanQinghao on 2019-05-08.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@class GQHNetworkError;

/**
 网络请求返回结果
 */
@interface GQHNetworkResult : NSObject

/**
 网络请求结果状态
 */
@property (nonatomic, assign) BOOL qh_status;

/**
 网络请求返回码
 */
@property (nonatomic, strong) NSNumber *qh_code;

/**
 网络请求返回提示信息
 */
@property (nonatomic, copy) NSString *qh_message;

/**
 网络请求成功返回内容
 */
@property (nonatomic, strong) NSDictionary *qh_response;

/**
 网络请求成功返回的数据("data")
 */
@property (nonatomic, strong) id qh_data;

/**
 网络请求返回的错误
 */
@property (nonatomic, strong) GQHNetworkError *qh_error;


/**
 初始化网络请求成功

 @param response 网络请求成功返回内容
 @return 网络请求成功结果
 */
- (instancetype)initWithSuccessResponse:(NSDictionary *)response;

/**
 初始化网络请求失败

 @param error 网络请求失败返回的错误
 @return 网络请求失败结果
 */
- (instancetype)initWithError:(GQHNetworkError *)error;

@end

NS_ASSUME_NONNULL_END
