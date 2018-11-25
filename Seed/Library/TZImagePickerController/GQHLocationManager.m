//
//  GQHLocationManager.m
//  GQHKit
//
//  Created by GuanQinghao on 01/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHLocationManager.h"

@interface GQHLocationManager () <CLLocationManagerDelegate>

// 定位管理
@property (nonatomic, strong) CLLocationManager *locationManager;

// 定位成功回调
@property (nonatomic, copy) void (^locationSuccessBlock)(CLLocation *latestLocation,CLLocation *location);

// 定位失败回调
@property (nonatomic, copy) void (^locationFailedBlock)(NSError *error);

// 编码成功回调
@property (nonatomic, copy) void (^geocodeBlock)(NSArray *geocodeArray);

@end


@implementation GQHLocationManager

+ (instancetype)qh_manager {
    
    static GQHLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
        manager.locationManager = [[CLLocationManager alloc] init];
        manager.locationManager.delegate = manager;
        [manager.locationManager requestWhenInUseAuthorization];
    });
    
    return manager;
}

- (void)qh_startLocation {
    
    [self qh_startLocationWithSuccessBlock:nil failureBlock:nil geocodeBlock:nil];
}

- (void)qh_startLocationWithSuccessBlock:(void (^)(CLLocation *latestLocation,CLLocation *location)) successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    
    [self qh_startLocationWithSuccessBlock:successBlock failureBlock:failureBlock geocodeBlock:nil];
}

- (void)qh_startLocationWithGeocodeBlock:(void (^)(NSArray *geocodeArray))geocodeBlock {
    
    [self qh_startLocationWithSuccessBlock:nil failureBlock:nil geocodeBlock:geocodeBlock];
}

- (void)qh_startLocationWithSuccessBlock:(void (^)(CLLocation *latestLocation,CLLocation *location)) successBlock failureBlock:(void (^)(NSError *error))failureBlock geocodeBlock:(void (^)(NSArray *geocodeArray))geocodeBlock {
    
    [self.locationManager startUpdatingHeading];
    _locationSuccessBlock = successBlock;
    _locationFailedBlock = failureBlock;
    _geocodeBlock = geocodeBlock;
}

#pragma mark --CLLocationManagerDelegate
// 地理位置发生变化时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    [manager stopUpdatingLocation];
#warning 位置数组按时间顺序排列
    CLLocation *latestLocation = [locations lastObject];
    CLLocation *location = [locations firstObject];
    
    if (_locationSuccessBlock) {
        
        _locationSuccessBlock(latestLocation,location);
    }
    if (_geocodeBlock) {
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:latestLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
           
            _geocodeBlock(placemarks);
        }];
    }
}

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"定位失败, 错误: %@",error);
    
    switch ([error code]) {
        case kCLErrorDenied: {
            // 用户拒绝定位权限
            
        }
            break;
            
        default:
            break;
    }
    if (_locationFailedBlock) {
        
        _locationFailedBlock(error);
    }
}

@end
