//
//  GQHHeader.h
//  Seed
//
//  Created by GuanQinghao on 17/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#ifndef GQHHeader_h
#define GQHHeader_h


/// 工程基类
#pragma mark - Classes
#import "GQHBaseModel.h"
#import "GQHBaseView.h"
#import "GQHBaseViewController.h"
#import "GQHUIController.h"
#import "GQHWebController.h"


/// 全局宏定义、常量类、公共类
#pragma mark - Macro
#import "GQHMacro.h"
#import "GQHConstantHelper.h"
#import "GQHLogger.h"


/// 网络请求
#pragma mark - Network
#import "GQHNetworkHelper.h"
#import "GQHNetworkResult.h"
#import "GQHNetworkError.h"
#import "GQHNetworkStatusMonitor.h"


/// 自定义库
#pragma mark - Library
#import "GQHBadgeView.h" // 小红点
#import "GQHDatePickerView.h" // 日期选择器
#import "GQHSinglePickerView.h" // 单列视图选择器
#import "GQHGlobalTimer.h" // 全局定时器


/// 类别头文件
#pragma mark - Category
#pragma mark --Foundation
#import "NSArray+GQHSafety.h"
#import "NSDate+GQHFormatter.h"
#import "NSDictionary+GQHJSON.h"
#import "NSDictionary+GQHSafety.h"
#import "NSMutableAttributedString+GQHAttributed.h"
#import "NSObject+GQHProperty.h"
#import "NSObject+GQHSwizzling.h"
#import "NSObject+GQHValidator.h"
#import "NSString+GQHEncrypt.h"
#import "NSString+GQHFormatter.h"
#import "NSString+GQHSafety.h"
#import "NSBundle+GQHBundle.h"


#pragma mark --UIKit
#import "AppDelegate+GQH3DTouch.h"
#import "AppDelegate+GQHEasterEggs.h"
#import "AppDelegate+GQHShare.h"
#import "UIApplication+GQHApplication.h"
#import "UIApplication+GQHFileManager.h"
#import "UIButton+GQHButton.h"
#import "UIColor+GQHColor.h"
#import "UIDevice+GQHDevice.h"
#import "UIFont+GQHFont.h"
#import "UIImage+GQHImage.h"
#import "UIResponder+GQHRouter.h"
#import "UITextView+GQHPlaceholder.h"
#import "UIView+GQHAnimation.h"
#import "UIView+GQHFrame.h"
#import "UIView+GQHHUD.h"
#import "UIViewController+GQHAlert.h"
#import "UIViewController+GQHPermission.h"

#pragma mark --GQH
#import "GQHBaseViewController+GQHNavigationBar.h"
#import "GQHBaseViewController+GQHNetworking.h"
#import "GQHBaseViewController+GQHRefresh.h"


/// CocoaPods库
#pragma mark - CocoaPods
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <SDWebImage/SDWebImage.h>
#import <YYModel.h>

#endif /* GQHHeader_h */
