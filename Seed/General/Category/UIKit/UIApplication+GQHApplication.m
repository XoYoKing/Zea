//
//  UIApplication+GQHApplication.m
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIApplication+GQHApplication.h"

@implementation UIApplication (GQHApplication)

// 应用程序版本号
- (NSString *)qh_applicationShortVersion {
    
    return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

// 应用程序构建版本号
- (NSString *)qh_applicationBuildVersion {
    
    return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleVersion"];
}

// 应用程序名称
- (NSString *)qh_applicationDisplayName {
    
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleName"];
}

// 应用程序唯一编号
- (NSString *)qh_applicationBundleID {
    
    return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleIdentifier"];
}


/// 拨打电话(弹出框提示) (使用前检查类型，非iPhone不能拨打电话)
- (void)qh_dialWithMobile:(NSString * _Nonnull)mobile {
    
    /// telprompt 可以上架
    NSString *URLString = [NSString stringWithFormat:@"telprompt:%@",mobile];
    
    if (@available(iOS 10.0, *)) {
        /// iOS10后可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString] options:@{ } completionHandler:^(BOOL success) {
            
            /// 拨打电话完成后处理
            
        }];
    } else {
        
        /// iOS10前可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
}

/// 发信息 (使用前检查类型，非iPhone不能发送信息)
- (void)qh_smsWithMobile:(NSString * _Nonnull)mobile {
    
    NSString *URLString = [NSString stringWithFormat:@"sms:%@",mobile];
    
    if (@available(iOS 10.0, *)) {
        /// iOS10后可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString] options:@{ } completionHandler:^(BOOL success) {
            
            /// 完成后处理
            
        }];
    } else {
        
        /// iOS10前可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
}

/// 发送邮件 (使用前检查网络、地址规则和本机邮箱地址设置)
- (void)qh_mailWithEmail:(NSString *)email {
    
    NSString *URLString = [NSString stringWithFormat:@"mailto:%@",email];
    
    if (@available(iOS 10.0, *)) {
        /// iOS10后可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString] options:@{ } completionHandler:^(BOOL success) {
            
            /// 完成后处理
            
        }];
    } else {
        
        /// iOS10前可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
}

/// 在iTunes中打开app (使用前检查网络)
- (void)qh_iTunesAppWithAppID:(NSString *)appID {
    
    NSString *URLString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8",appID];
    
    if (@available(iOS 10.0, *)) {
        /// iOS10后可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString] options:@{ } completionHandler:^(BOOL success) {
            
            /// 完成后处理
            
        }];
    } else {
        
        /// iOS10前可用
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
}


@end
