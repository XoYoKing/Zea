//
//  UIApplication+GQHApplication.h
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (GQHApplication)

/// 应用程序版本号
@property (nonatomic, readonly, copy) NSString *qh_applicationShortVersion;
- (NSString *)qh_applicationShortVersion;
/// 应用程序构建版本号
@property (nonatomic, readonly, copy) NSString *qh_applicationBuildVersion;
- (NSString *)qh_applicationBuildVersion;
/// 应用程序名称
@property (nonatomic, readonly, copy) NSString *qh_applicationDisplayName;
- (NSString *)qh_applicationDisplayName;
/// 应用程序唯一编号
@property (nonatomic, readonly, copy) NSString *qh_applicationBundleID;
- (NSString *)qh_applicationBundleID;

/// 拨打电话(弹出框提示) (使用前检查类型，非iPhone不能拨打电话)
- (void)qh_dialWithMobile:(NSString * _Nonnull)mobile;

/// 发信息 (使用前检查类型，非iPhone不能发送信息)
- (void)qh_smsWithMobile:(NSString * _Nonnull)mobile;

/// 发送邮件 (使用前检查网络、地址规则和本机邮箱地址设置)
- (void)qh_mailWithEmail:(NSString *)email;

/// 在iTunes中打开app (使用前检查网络)
- (void)qh_iTunesAppWithAppID:(NSString *)appID;


@end
