//
//  UIDevice+GQHDevice.h
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, GQHDeviceType) {
    
    unknown = 0,
    simulator = 100,            // iPhone设备
    iPhone_1G,
    iPhone_3G,
    iPhone_3GS,
    iPhone_4,
    iPhone_4s,
    iPhone_5,
    iPhone_5c,
    iPhone_5s,
    iPhone_SE,
    iPhone_6,
    iPhone_6_Plus,
    iPhone_6s,
    iPhone_6s_Plus,
    iPhone_7,
    iPhone_7_Plus,
    iPhone_8,
    iPhone_8_Plus,
    iPhone_X,
    iPhone_XR,
    iPhone_Xs,
    iPhone_Xs_Max,
    
    iPod_Touch_1 = 200,         // iPod设备
    iPod_Touch_2,
    iPod_Touch_3,
    iPod_Touch_4,
    iPod_Touch_5,
    iPod_Touch_6,
    
    iPad = 300,                 // iPod设备
    iPad_2,
    iPad_3,
    iPad_4,
    iPad_Air,
    iPad_Air_2,
    iPad_Air_3,
    iPad_mini,
    iPad_mini_2,
    iPad_mini_3,
    iPad_mini_4,
    iPad_mini_5,
    iPad_Pro_129,//12.9寸
    iPad_Pro_97,//9.7寸
    iPad_2017,
    iPad_Pro_105_2,//10.5寸
    iPad_Pro_129_2,//12.9寸
    iPad_2018,
    
    Apple_Watch_1 = 400,        // Apple Watch设备
    Apple_Watch_2,
    Apple_Watch_3,
    Apple_Watch_4,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (GQHDevice)

/**
 运营商名称
 */
@property (nonatomic, readonly, copy) NSString *qh_carrierName;

/**
 运营商名称

 @return 运营商名称
 */
- (NSString *)qh_carrierName;

/**
 运营商代号
 */
@property (nonatomic, readonly, copy) NSString *qh_carrierCode;

/**
 运营商代号

 @return 运营商代号
 */
- (NSString *)qh_carrierCode;

/**
 手机磁盘总量(GB)
 */
@property (nonatomic, readonly, assign) CGFloat qh_diskTotalSize;

/**
 手机磁盘总量(GB)

 @return 手机磁盘总量(GB)
 */
- (CGFloat)qh_diskTotalSize;

/**
 手机可用磁盘容量(GB)
 */
@property (nonatomic,readonly, assign) CGFloat qh_diskFreeSize;

/**
 手机可用磁盘容量(GB)

 @return 手机可用磁盘容量(GB)
 */
- (CGFloat)qh_diskFreeSize;

/**
 手机可用内存容量(MB)
 */
@property (nonatomic,readonly, assign) CGFloat qh_memoryFreeSize;

/**
 手机可用内存容量(MB)

 @return 手机可用内存容量(MB)
 */
- (CGFloat)qh_memoryFreeSize;

@end

NS_ASSUME_NONNULL_END
