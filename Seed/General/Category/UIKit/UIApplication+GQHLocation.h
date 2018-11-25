//
//  UIApplication+GQHLocation.h
//  Seed
//
//  Created by Mac on 2018/7/20.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface UIApplication (GQHLocation) <CLLocationManagerDelegate>

/// 全局位置管理器
@property (nonatomic, readonly, strong)  CLLocationManager *qh_shareLocationManager;

/// 检测设备系统地图定位权限 (返回NO引导用户开启定位)
- (BOOL)qh_checkLocationPermissions;

@end
