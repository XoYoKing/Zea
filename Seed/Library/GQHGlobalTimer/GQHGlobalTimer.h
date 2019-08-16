//
//  GQHGlobalTimer.h
//  Seed
//
//  Created by Mac on 2019/5/30.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 全局定时器block回调

 @param timeStamp 当前时间戳
 */
typedef void(^GQHGLobalTimerBlock)(double timeStamp);


NS_ASSUME_NONNULL_BEGIN

@interface GQHGlobalTimer : NSObject

/**
 当前时间戳(单位:秒)
 */
@property (nonatomic, assign, readonly) double qh_timeStamp;

/**
 全局定时器block回调
 */
@property (nonatomic, copy) GQHGLobalTimerBlock qh_block;

/**
 初始化全局定时器并开始计时

 @return 全局定时器
 */
+ (instancetype)qh_sharedGlobalTimer;

/**
 启动全局定时器
 */
- (void)qh_resumeTimer;


@end

NS_ASSUME_NONNULL_END

/**
 [GQHGlobalTimer qh_sharedGlobalTimer].qh_block = ^(double timeStamp) {
 
    NSInteger diff = round(timeStamp - self.timeStamp);
 
    if (0 <= diff && diff < 60) {
 
        // 倒计时
        NSLog(@"倒计时-----> %@",@(60-diff));
    } else if (diff > (7 * 24 * 3600)) {
 
        self.timeStamp = timeStamp;
    }
 };
 */
