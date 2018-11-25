//
//  GQHLocationManager.h
//  GQHKit
//
//  Created by GuanQinghao on 01/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GQHLocationManager : NSObject

// 定位单例
+ (instancetype)qh_manager;

// 开始定位
- (void)qh_startLocation;

// 定位成功或失败回调
- (void)qh_startLocationWithSuccessBlock:(void (^)(CLLocation *latestLocation,CLLocation *location))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

// 定位地理编码
- (void)qh_startLocationWithGeocodeBlock:(void (^)(NSArray *geocodeArray))geocodeBlock;

// 定位成功或失败并进行地理编码
- (void)qh_startLocationWithSuccessBlock:(void (^)(CLLocation *latestLocation,CLLocation *location)) successBlock failureBlock:(void (^)(NSError *error))failureBlock geocodeBlock:(void (^)(NSArray *geocodeArray))geocodeBlock;

@end
