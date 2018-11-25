
//
//  UIApplication+GQHLocation.m
//  Seed
//
//  Created by Mac on 2018/7/20.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIApplication+GQHLocation.h"
#import <objc/message.h>

static CLLocationManager *manager;
@implementation UIApplication (GQHLocation)

/// 检测设备系统地图定位权限 (返回NO引导用户开启定位)
- (BOOL)qh_checkLocationPermissions {
    
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"设备启用定位服务");
        
        /// 检测当前应用程序的定位服务权限状态
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        
        if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
            /// 定位服务权限状态为 Always 或 WhenInUse
            return YES;
        }
    }
    
    return NO;
}

/// 定位管理器(单例)
- (CLLocationManager *)qh_shareLocationManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[CLLocationManager alloc] init];
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        manager.distanceFilter = 5;//距离筛选5米
        manager.headingFilter = 1;
        manager.allowsBackgroundLocationUpdates = YES;
    });
    
    return manager;
}

@end
