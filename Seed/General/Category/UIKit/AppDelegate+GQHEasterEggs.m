//
//  AppDelegate+GQHEasterEggs.m
//  Seed
//
//  Created by Mac on 2019/5/30.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate+GQHEasterEggs.h"
#import "GQHHeader.h"


/// 点击次数
NSInteger kClicks;
/// 执行次数
NSInteger kCount;

@implementation AppDelegate (GQHEasterEggs)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    CGPoint touchPoint = [[touches anyObject] locationInView:self.window];
    CGRect statusBarFrame = UIApplication.sharedApplication.statusBarFrame;
    
    // 3秒内点击状态栏10次以上
    if (CGRectContainsPoint(statusBarFrame, touchPoint)) {
        
        kClicks++;
        [GQHGlobalTimer qh_sharedGlobalTimer].qh_block = ^(double timeStamp) {
            
            kCount++;
            
            if (kCount > 3) {
                
                if (kClicks > 10) {
                    
                    if ([UIApplication.sharedApplication.keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
                        
                        GQHUIController *UIController = [[GQHUIController alloc] init];
                        UINavigationController *navUIController = [[UINavigationController alloc] initWithRootViewController:UIController];
                        self.window.rootViewController = navUIController;
                    } else if ([UIApplication.sharedApplication.keyWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
                        
                        GQHTabBarController *tabBarController = [[GQHTabBarController alloc] init];
                        self.window.rootViewController = tabBarController;
                    }
                }
                
                kClicks = 0;
                kCount = 0;
            }
        };
    }
}

@end
