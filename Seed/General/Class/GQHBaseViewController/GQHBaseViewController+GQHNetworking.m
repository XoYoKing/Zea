//
//  GQHBaseViewController+GQHNetworking.m
//  Seed
//
//  Created by Mac on 2019/5/23.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseViewController+GQHNetworking.h"
#import "GQHHeader.h"


@implementation GQHBaseViewController (GQHNetworking)

/**
 添加联网监听器
 */
- (void)qh_addNetworkingMonitor {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkingStatus:) name:GQHNetStatusMonitorNotificationKey object:nil];
}

/**
 移除联网监听器
 */
- (void)qh_removeNetworkingMonitor {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GQHNetStatusMonitorNotificationKey object:nil];
}

/**
 联网状态监听

 @param sender 通知回调信息
 */
- (void)networkingStatus:(NSNotification *)sender {
    
    if ([GQHNetworkStatusMonitor qh_sharedNetStatusMonitor].qh_networking) {
        
        GQHNetworkStatus networkStatus = (GQHNetworkStatus)[[sender.userInfo objectForKey:@"status"] integerValue];
        
        // 有网
        if ([self isEqual:[self.view qh_currentViewController]]) {
            
            [self qh_networkConnected:networkStatus];
        }
    } else {
        
        // 无网
        [self showToastWithText:@"未连接到网络"];
    }
}

/**
 网络已连接, 网络变化时需要刷新的请求放在这里

 @param status 网络状态分类
 */
- (void)qh_networkConnected:(GQHNetworkStatus)status {
    
}

/**
 处理请求错误
 
 @param error 请求错误
 */
- (void)qh_handleNetworkError:(GQHNetworkError *)error {
    
    //TODO:统一处理请求错误
    
}

@end
