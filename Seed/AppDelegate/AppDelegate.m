//
//  AppDelegate.m
//  Seed
//
//  Created by GuanQinghao on 09/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "AppDelegate.h"
#import "GQHHeader.h"
#import "GQHHomeController.h"
#import "AppDelegate+GQHDatabaseInstaller.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 0.应用程序本地沙盒路径
    NSLog(@"%@",UIApplication.sharedApplication.qh_documentsPath);
    
    // 1.初始化应用程序窗口
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    
    // 2. 设置根视图
    // 2.1 启动广告页根视图
//    GQHLaunchController *launchController = [[GQHLaunchController alloc] init];
//    UINavigationController *launchNavController = [[UINavigationController alloc] initWithRootViewController:launchController];
//    self.window.rootViewController = launchNavController;
    
    // 2.2 首页根视图
    GQHHomeController *homeController = [[GQHHomeController alloc] init];
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    self.window.rootViewController = homeNavController;
    
    // 2.3 UI根视图
//    GQHUIController *UIController = [[GQHUIController alloc] init];
//    UINavigationController *UINavController = [[UINavigationController alloc] initWithRootViewController:UIController];
//    self.window.rootViewController = UINavController;
    
    // 3.记录器
#ifdef DEBUG
    [GQHLogger qh_sharedLogger].hidden = NO;
#else
    [GQHLogger qh_sharedLogger].hidden = YES;
#endif
    
    // 4.app初始化设置
    [self defaultAppConfiguration];
    
    // 5.监听网络
    [[GQHNetworkStatusMonitor qh_sharedNetStatusMonitor] qh_monitorNetStatus];
    
    // 6.3D Touch 功能
    // [self qh_creatAppShortcutItems];
    
    // 7、添加全局定时器
    [[GQHGlobalTimer qh_sharedGlobalTimer] qh_resumeTimer];
    
    // 8.内购服务
    [self qh_IAPServerWithOptions:launchOptions];
    
    // 9.初始化数据库
    [self qh_installDatabase];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // 应用进入后台 暂停定时器
//    [homeController.qh_timer setFireDate:[NSDate distantFuture]];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    // 应用进入前台 如果游戏进行中则开启定时器
//    if (homeController.qh_running) {
//
//        [homeController.qh_timer setFireDate:[NSDate distantPast]];
//    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 初次启动配置应用程序默认设置
 */
- (void)defaultAppConfiguration {
    
    if (![NSUserDefaults.standardUserDefaults objectForKey:GQHGameImageKey]) {
        
        [NSUserDefaults.standardUserDefaults setObject:@"db_gallery_cultural_0" forKey:GQHGameImageKey];
    }
    
    if (![NSUserDefaults.standardUserDefaults objectForKey:GQHGameLevelOrderKey]) {

        [NSUserDefaults.standardUserDefaults setObject:@"3" forKey:GQHGameLevelOrderKey];
        [NSUserDefaults.standardUserDefaults setObject:@"newbie" forKey:GQHGameLevelTitleKey];
    }
}

@end
