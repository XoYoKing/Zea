//
//  GQHNetworkError.h
//
//  Created by GuanQinghao on 2019-05-08.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 网络请求失败返回错误
 */
@interface GQHNetworkError : NSObject

/**
 错误码
 */
@property (nonatomic, strong) NSNumber *qh_code;

/**
 错误提示信息
 */
@property (nonatomic, copy) NSString *qh_message;

/**
 是否是网络错误
 */
@property (nonatomic, assign) BOOL qh_networkError;

/**
 如果是网络错误，为AFNetworking返回的error,否则为nil
 */
@property (nonatomic, strong) NSError *qh_AFError;

/**
 如果不是网络错误，为服务器返回的数据，否则为nil
 */
@property (nonatomic, strong) NSDictionary *qh_info;

/**
 初始化错误

 @param error AFNetworking返回的error
 @param info 服务器返回的错误信息
 @return 网络请求失败返回错误
 */
- (instancetype)initWithAFError:(NSError * _Nullable ) error info:(NSDictionary * _Nullable)info;

@end

NS_ASSUME_NONNULL_END
