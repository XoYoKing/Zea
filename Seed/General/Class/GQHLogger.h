//
//  GQHLogger.h
//  Seed
//
//  Created by Hao on 2018/8/20.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GQHLogger : UIWindow

/// 记录器单例
+ (instancetype)qh_sharedLogger;

/// 输出记录
+ (void)qh_print:(NSString *)text;
/// 输出记录
- (void)qh_print:(NSString *)text;

/// 清除记录
+ (void)qh_clear;
/// 清除记录
- (void)qh_clear;

@end
