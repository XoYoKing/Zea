//
//  GQHLocationManager.m
//  Xanthium
//
//  Created by GuanQinghao on 03/05/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHLocationManager.h"
#import "GQHHeader.h"

@interface GQHLocationManager () <CLLocationManagerDelegate> {
    
    CLLocationManager *locationManager;
}

@end


@implementation GQHLocationManager

/// 定位管理器(单例)
+ (instancetype)qh_sharedLocationManager {
    
    static GQHLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[[self class] alloc] init];
    });
    
    return manager;
}

/// 开始定位
- (void)qh_startUpdatingLocation {
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1;
    locationManager.headingFilter = 1;
    locationManager.allowsBackgroundLocationUpdates = YES;
    
    if ([CLLocationManager locationServicesEnabled]) {
        DLog(@"设备启用定位服务");
        
        /// 检测当前应用程序的定位服务权限状态
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        
        if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
            
            /// 定位服务权限状态为 Always 或 WhenInUse, 开始定位
            [locationManager startUpdatingLocation];
        } else {
            
            /// 请求定位服务权限 Always 状态
            if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                
                [locationManager requestAlwaysAuthorization];
            }
        }
    } else {
        NSLog(@"设备未启用定位服务 (关闭定位服务、飞行模式)");
        
        /// 弹窗提醒开启设备定位服务
//        [[[UIApplication sharedApplication] keyWindow] showToastWithText:@"定位服务未授权，请授权定位服务以便获取位置信息"];
    }
}

/// 停止定位
- (void)qh_stopUpdatingLocation {
    
    [locationManager stopUpdatingLocation];
}

/// 代理-位置信息刷新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location =  [locations firstObject];
    [self uploadUserLocationWith:location];
    
    /// 每次启动应用程序上传一次定位信息
    [locationManager stopUpdatingLocation];
}

/// 上传定位信息
- (void)uploadUserLocationWith:(CLLocation *)location {
    
//    NSString *latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setObject:USER_GET_ID forKey:@"userId"];
//    [parameters setObject:latitude forKey:@"latitude"];
//    [parameters setObject:longitude forKey:@"longitude"];
//
//    NSString *APIURLString = [[NSString qh_APIURLString] stringByAppendingPathComponent:@"/localtion/1/update"];
//    [GQHNetHelper qh_requestGET:APIURLString parameters:parameters success:^(NSNumber *code, NSString *message, NSDictionary *data) {
//        DLog(@"%@---%@---%@",code,message,data);
//
//    } failure:^(NSError *error) {
//
//    }];
}

@end
