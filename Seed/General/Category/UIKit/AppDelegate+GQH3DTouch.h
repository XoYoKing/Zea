//
//  AppDelegate+GQH3DTouch.h
//  Seed
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (GQH3DTouch)

/**
 代码创建应用程序主屏 3D Touch 快捷选项 - Home Screen Quick Actions
 在 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions; 中调用该方法
 */
- (void)qh_creatAppShortcutItems;

@end

NS_ASSUME_NONNULL_END
