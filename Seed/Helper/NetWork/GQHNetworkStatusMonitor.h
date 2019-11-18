//
//  GQHNetworkStatusMonitor.h
//
//  Created by GuanQinghao on 2019-05-08.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


/// 网络状态监听通知key
UIKIT_EXTERN NSString * _Nonnull const GQHNetStatusMonitorNotificationKey;

/**
 网络状态

 - GQHNetworkStatusUnknown: 未知网络
 - GQHNetworkStatusNotReachable: 无网络
 - GQHNetworkStatusReachableViaWWAN: 手机网络(E网、3G网、4G网)
 - GQHNetworkStatusReachableViaWiFi: Wi-Fi网络
 */
typedef NS_ENUM(NSInteger, GQHNetworkStatus) {
    
    GQHNetworkStatusUnknown          = -1,
    GQHNetworkStatusNotReachable     = 0,
    GQHNetworkStatusReachableViaWWAN = 1,
    GQHNetworkStatusReachableViaWiFi = 2,
};


NS_ASSUME_NONNULL_BEGIN

/**
 网络状态监听器
 */
@interface GQHNetworkStatusMonitor : NSObject

/**
 联网状态
 */
@property (nonatomic, assign) BOOL qh_networking;

/**
 网络状态
 */
@property (nonatomic, assign) GQHNetworkStatus qh_networkStaus;

/**
 网络状态监听单例
 
 @return 网络状态监听单例
 */
+ (instancetype)qh_sharedNetStatusMonitor;

/**
 监听网络
 */
- (void)qh_monitorNetStatus;

@end

NS_ASSUME_NONNULL_END
