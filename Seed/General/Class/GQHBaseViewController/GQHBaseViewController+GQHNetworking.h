//
//  GQHBaseViewController+GQHNetworking.h
//  Seed
//
//  Created by Mac on 2019/5/23.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseViewController.h"
#import "GQHNetworkStatusMonitor.h"
#import "GQHNetworkError.h"


NS_ASSUME_NONNULL_BEGIN

/**
 基类网络监听
 */
@interface GQHBaseViewController (GQHNetworking)

/**
 添加联网监听器
 */
- (void)qh_addNetworkingMonitor;

/**
 移除联网监听器
 */
- (void)qh_removeNetworkingMonitor;

/**
 网络已连接, 网络变化时需要刷新的请求放在这里
 
 @param status 网络状态分类
 */
- (void)qh_networkConnected:(GQHNetworkStatus)status;

/**
 处理请求错误
 
 @param error 请求错误
 */
- (void)qh_handleNetworkError:(GQHNetworkError *)error;

@end

NS_ASSUME_NONNULL_END
