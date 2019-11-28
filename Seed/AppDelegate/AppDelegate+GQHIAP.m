//
//  AppDelegate+GQHIAP.m
//  Seed
//
//  Created by Mac on 2019/10/21.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate+GQHIAP.h"
#import "GQHIAPManager.h"


@implementation AppDelegate (GQHIAP)

/**
 初始化IAP服务
 
 @param launchOptions 启动方式
 */
- (void)qh_IAPServerWithOptions:(NSDictionary *)launchOptions {
    
    // 应用程序启动完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLaunch:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    // 应用程序将要被终止
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:UIApplicationWillTerminateNotification object:nil];
}

/**
 启动内购服务

 @param notification 应用程序启动通知
 */
- (void)didLaunch:(NSNotification *)notification {
    
    [[GQHIAPManager qh_sharedIAPMannager] qh_startMonitoringIAP];
}

/**
 停止内购服务

 @param notification 应用程序被终止通知
 */
- (void)willTerminate:(NSNotification *)notification {
    
    [[GQHIAPManager qh_sharedIAPMannager] qh_stopMonitoringIAP];
}

@end
