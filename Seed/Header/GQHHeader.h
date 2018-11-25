//
//  GQHHeader.h
//  Seed
//
//  Created by GuanQinghao on 17/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#ifndef GQHHeader_h
#define GQHHeader_h

/// 全局宏定义
#pragma mark Macro
#import "GQHMacro.h"
#import "GQHCommonCell.h"
#import "GQHConstantHelper.h"
#import "GQHLogger.h"

/// 类别头文件
#pragma mark Category

#pragma mark --Foundation
#import "NSDate+GQHFormatter.h"
#import "NSDictionary+GQHJSON.h"
#import "NSObject+GQHSwizzling.h"
#import "NSString+GQHAPI.h"
#import "NSString+GQHEncrypt.h"
#import "NSString+GQHFormatter.h"
#import "NSString+GQHPredicate.h"

#pragma mark --UIKit
#import "UIApplication+GQHApplication.h"
#import "UIApplication+GQHFileManager.h"
#import "UIApplication+GQHLocation.h"
#import "UIButton+GQHButton.h"
#import "UIColor+GQHColor.h"
#import "UIDevice+GQHDevice.h"
#import "UIFont+GQHFont.h"
#import "UIImage+GQHImage.h"
#import "UIView+GQHAnimation.h"
#import "UIView+GQHFrame.h"
#import "UIView+GQHHUD.h"
#import "UIViewController+GQHPermission.h"


/// CocoaPods库
#pragma mark CocoaPods
#import <AFNetworking.h>
#import <Masonry.h>
#import <MJRefresh.h>

#endif /* GQHHeader_h */
