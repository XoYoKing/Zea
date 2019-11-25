//
//  GQHGlobalTimer.m
//  Seed
//
//  Created by Mac on 2019/5/30.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHGlobalTimer.h"


@interface GQHGlobalTimer ()

/**
 GCD定时器
 */
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation GQHGlobalTimer

static GQHGlobalTimer *globalTimer = nil;
/**
 初始化全局定时器并开始计时
 
 @return 全局定时器
 */
+ (instancetype)qh_sharedGlobalTimer {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        globalTimer = [[[self class] alloc] init];
        
        // 获取全局并发队列
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        // 创建GCD定时器
        globalTimer.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        // 设置定时器的开始时间、间隔时间和精准度
        dispatch_source_set_timer(globalTimer.timer, DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC, 1.0f * NSEC_PER_SEC);
    });
    
    return globalTimer;
}

/**
 启动全局定时器
 */
- (void)qh_resumeTimer {
    
    __weak typeof(self) weakSelf = self;
    
    // 设置定时器要调用的方法
    dispatch_source_set_event_handler([GQHGlobalTimer qh_sharedGlobalTimer].timer, ^{
        
        // 主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"全局定时器运行中,当前系统的时间戳:%@", @(self.qh_timeStamp));
            
            if (weakSelf.qh_block) {
                
                weakSelf.qh_block(weakSelf.qh_timeStamp);
            }
        });
    });
    
    // 启动定时器
    dispatch_resume(globalTimer.timer);
}

/**
 当前时间戳(单位:秒)
 */
- (double)qh_timeStamp {
    
    return [[NSDate date] timeIntervalSince1970];
}

@end
