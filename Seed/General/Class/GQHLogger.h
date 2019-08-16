//
//  GQHLogger.h
//  Seed
//
//  Created by Hao on 2018/8/20.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GQHLogger : UIWindow

/**
 日志记录器单例

 @return 日志记录器单例
 */
+ (instancetype)qh_sharedLogger;

/**
 输出日志记录

 @param text 日志记录
 */
+ (void)qh_print:(NSString *)text;

/**
 输出日志记录

 @param text 日志记录
 */
- (void)qh_print:(NSString *)text;

/**
 清除日志记录
 */
+ (void)qh_clear;

/**
 清除日志记录
 */
- (void)qh_clear;

@end


#pragma mark - Manual
/**
 
 1、在AppDelegate中启动记录器
 
 // 记录器
 [GQHLogger qh_sharedLogger].hidden = NO;
 
 2、输出打印记录
 
 // 类方法打印记录
 [GQHLogger qh_print:@"类方法"];
 
 // 实例方法打印记录
 [[GQHLogger qh_sharedLogger] qh_print:@"实例方法"];
 
 3、清除记录
 
 // 类方法清除记录
 [GQHLogger qh_clear];
 
 // 实例方法清除记录
 [[GQHLogger qh_sharedLogger] qh_clear];
 
 */
