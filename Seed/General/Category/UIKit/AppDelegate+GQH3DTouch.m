//
//  AppDelegate+GQH3DTouch.m
//  Seed
//
//  Created by Mac on 2019/5/24.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate+GQH3DTouch.h"


@implementation AppDelegate (GQH3DTouch)

/**
 代码创建应用程序主屏 3D Touch 快捷选项 - Home Screen Quick Actions
 在 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions; 中调用该方法
 */
- (void)qh_creatAppShortcutItems {
    
    // 创建系统风格的icon
    UIApplicationShortcutIcon *systemAddIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *addShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.add" localizedTitle:NSLocalizedString(@"Add", @"") localizedSubtitle:NSLocalizedString(@"", @"") icon:systemAddIcon userInfo:nil];
    
    // 创建系统风格的icon
    UIApplicationShortcutIcon *composeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *composeShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.compose" localizedTitle:NSLocalizedString(@"Compose", @"") localizedSubtitle:NSLocalizedString(@"", @"") icon:composeIcon userInfo:nil];
    
    // 创建系统风格的icon
    UIApplicationShortcutIcon *systemSearchIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *searchShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.search" localizedTitle:NSLocalizedString(@"Search", @"") localizedSubtitle:NSLocalizedString(@"", @"") icon:systemSearchIcon userInfo:nil];
    
    // 创建自定义风格的icon 图片大小35×35
    UIApplicationShortcutIcon *customPraiseIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon.png"];
    // 创建应用程序主屏3D Touch快捷选项
    UIApplicationShortcutItem *praiseShortcut = [[UIApplicationShortcutItem alloc]initWithType:@"identifier.praise" localizedTitle:NSLocalizedString(@"Praise", @"") localizedSubtitle:NSLocalizedString(@"", @"") icon:customPraiseIcon userInfo:nil];
    
    // 添加到快捷选项数组  启用3D Touch功能后应用上架自动添加一个分享快捷选项
    [UIApplication sharedApplication].shortcutItems = @[addShortcut,composeShortcut,searchShortcut,praiseShortcut];
}

/**
 3D Touch 快捷选项代理方法
 */
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    // 根据Item对应的type标识处理对应的点击操作
    NSString *type = shortcutItem.type;
    
    if ([type isEqualToString:@"identifier.add"]) {
        
        NSLog(@"添加");
    } else if ([type isEqualToString:@"identifier.compose"]) {
        
        NSLog(@"组合");
    } else if ([type isEqualToString:@"identifier.search"]) {
        
        NSLog(@"搜索");
    } else if ([type isEqualToString:@"identifier.praise"]) {
        
        NSLog(@"点赞");
    }
}

@end
