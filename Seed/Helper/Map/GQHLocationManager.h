//
//  GQHLocationManager.h
//  Xanthium
//
//  Created by GuanQinghao on 03/05/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface GQHLocationManager : NSObject

/// 定位管理器(单例)
+ (instancetype)qh_sharedLocationManager;
/// 开始定位
- (void)qh_startUpdatingLocation;
/// 停止定位
- (void)qh_stopUpdatingLocation;

@end
