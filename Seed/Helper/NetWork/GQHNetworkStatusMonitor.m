//
//  GQHNetworkStatusMonitor.m
//
//  Created by GuanQinghao on 2019-05-08.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHNetworkStatusMonitor.h"
#import <AFHTTPSessionManager.h>


/// 网络状态监听通知key
NSString * const GQHNetStatusMonitorNotificationKey = @"GQHNetStatusMonitorNotificationKey";

@implementation GQHNetworkStatusMonitor

/**
 网络状态监听单例
 
 @return 网络状态监听单例
 */
+ (instancetype)qh_shareNetStatusMonitor {
    
    static GQHNetworkStatusMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        monitor = [[GQHNetworkStatusMonitor alloc] init];
    });
    
    return monitor;
}

/**
 监听网络
 */
- (void)qh_monitorNetStatus {
    
    // 网络监听管理器
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        self.qh_networking = YES;
        
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown: {
                
                self.qh_networkStaus = GQHNetworkStatusUnknown;
            }
                break;
                
            case AFNetworkReachabilityStatusNotReachable: {
                
                self.qh_networkStaus = GQHNetworkStatusNotReachable;
                self.qh_networking = NO;
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                
                self.qh_networkStaus = GQHNetworkStatusReachableViaWWAN;
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                
                self.qh_networkStaus = GQHNetworkStatusReachableViaWiFi;
            }
                break;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:GQHNetStatusMonitorNotificationKey object:nil userInfo:@{@"status":@(self.qh_networkStaus)}];
    }];
    
    // 开始监听网络状态
    [manager startMonitoring];
}

@end
