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
#import <UserNotifications/UserNotifications.h>

#import "GQHLogger.h"
#import "GQHGuideView.h"


@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    // 记录器
    [GQHLogger qh_sharedLogger].hidden = NO;
    
    GQHHomeController *homeController = [[GQHHomeController alloc] init];
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    self.window.rootViewController = homeNavController;
    
    [self.window makeKeyAndVisible];
    
    // 游戏配置
    [self defaultConfiguration];
    // 全局状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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

/// 初次启动配置应用程序默认设置
- (void)defaultConfiguration {
    
    if (![NSUserDefaults.standardUserDefaults objectForKey:GQHUserImageKey]) {
        
        [NSUserDefaults.standardUserDefaults setObject:@"puzzle_4" forKey:GQHUserImageKey];
    }
    
    if (![NSUserDefaults.standardUserDefaults objectForKey:GQHUserLevelKey]) {
        
        [NSUserDefaults.standardUserDefaults setObject:[NSNumber numberWithInteger:GQHUserLevelNormal] forKey:GQHUserLevelKey];
    }
    
    if (![NSUserDefaults.standardUserDefaults objectForKey:GQHUserSoundKey]) {
        
        [NSUserDefaults.standardUserDefaults setObject:@"sound_0" forKey:GQHUserSoundKey];
    }
}

/// 创建应用程序主屏3D Touch快捷选项 -- Home Screen Quick Actions
- (void)creatAppShortcutItems {
    
    if (@available(iOS 9.0, *)) {
        
        //创建系统风格的icon
        UIApplicationShortcutIcon *systemAddIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
        //创建应用程序主屏3D Touch快捷选项
        UIApplicationShortcutItem *addShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.add" localizedTitle:@"Add" localizedSubtitle:@"" icon:systemAddIcon userInfo:nil];
        //创建系统风格的icon
        UIApplicationShortcutIcon *composeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
        //创建应用程序主屏3D Touch快捷选项
        UIApplicationShortcutItem *composeShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.compose" localizedTitle:@"Compose" localizedSubtitle:@"" icon:composeIcon userInfo:nil];
        
        //创建系统风格的icon
        UIApplicationShortcutIcon *systemSearchIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
        //创建应用程序主屏3D Touch快捷选项
        UIApplicationShortcutItem *searchShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.search" localizedTitle:@"Search" localizedSubtitle:@"" icon:systemSearchIcon userInfo:nil];
        
        //创建自定义风格的icon 图片大小35×35
        UIApplicationShortcutIcon *customPraiseIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon.png"];
        //创建应用程序主屏3D Touch快捷选项
        UIApplicationShortcutItem *praiseShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.praise" localizedTitle:@"Praise" localizedSubtitle:@"" icon:customPraiseIcon userInfo:nil];
        
        //添加到快捷选项数组  启用3D Touch功能后应用上架自动添加一个分享快捷选项
        [UIApplication sharedApplication].shortcutItems = @[addShortcut,composeShortcut,searchShortcut,praiseShortcut];
    } else {
        // Fallback on earlier versions
        
    }
}

@end
