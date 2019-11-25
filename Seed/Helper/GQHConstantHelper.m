//
//  GQHConstantHelper.m
//  Seed
//
//  Created by GuanQinghao on 2018/6/16.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHConstantHelper.h"


#pragma mark - color


#pragma mark - font color
/// 黑色 #111111
NSString * const GQHFontColorBlack = @"#111111";
/// 深黑色 #333333
NSString * const GQHFontColorDarkBlack = @"#333333";
/// 深灰色 #666666
NSString * const GQHFontColorDarkGray = @"#666666";
/// 灰色 #999999
NSString * const GQHFontColorGray = @"#999999";
/// 浅灰色 #CCCCCC
NSString * const GQHFontColorLightGray = @"#CCCCCC";
/// 白色 #FFFFFF
NSString * const GQHFontColorWhite = @"#FFFFFF";


#pragma mark - font size
/// 正文、列表正文
CGFloat const GQHFontSizeSmallest = 10.0f;
/// 副文、列表副文
CGFloat const GQHFontSizeSmaller = 14.0f;
/// 最小字体 小字
CGFloat const GQHFontSizeDefault = 16.0f;
/// 标题、按钮
CGFloat const GQHFontSizeBigger = 18.0f;
/// 最大字体 导航、突出内容
CGFloat const GQHFontSizeBiggest = 20.0f;


#pragma mark - font name
/// 苹方-简 中黑体
NSString * const GQHFontNamePFSMedium = @"PingFangSC-Medium";
/// 苹方-简 中粗体
NSString * const GQHFontNamePFSSemibold = @"PingFangSC-Semibold";
/// 苹方-简 常规体
NSString * const GQHFontNamePFSRegular = @"PingFangSC-Regular";


#pragma mark - UI
/// 全局常量-间距
CGFloat const GQHSpacing = 10.0f;
/// 全局常量-单倍外边距
CGFloat const GQHSingleMargin = 15.0f;
/// 全局常量-双倍外边距
CGFloat const GQHDoubleMargin = 2 * GQHSingleMargin;
/// 全局常量-线的粗细
CGFloat const GQHLineWidth = 0.75f;
/// 视图布局最小尺寸
CGFloat const GQHLayoutMinValue = 10.0f;
/// 普通按钮高度
CGFloat const GQHButtonNormalHeight = 44.0f;
/// UI圆角
CGFloat const GQHUICornerRadius = 5.0f;


#pragma makr - network
/// 成功code 1
NSInteger const GQHHTTPStatusOKCode = 1;
/// 服务器错误code 500
NSInteger const GQHHTTPStatusServiceErrorCode = 500;
/// 无服务code 503
NSInteger const GQHHTTPStatusNoServiceCode = 503;
/// 无效的令牌code 401
NSInteger const GQHHTTPStatusUnauthorizedCode = 401;

#ifdef DEBUG
/// 接口根域名地址
NSString * const GQHAPIServerBaseURL = @"";
/// 接口路径地址
NSString * const GQHAPIPathURL = @"";
/// 图片服务器地址
NSString * const GQHPictureServerURL = @"";
/// 文件服务器地址
NSString * const GQHFileServerURL = @"";
#else
/// 接口根域名地址
NSString * const GQHAPIServerBaseURL = @"";
/// 接口路径地址
NSString * const GQHAPIPathURL = @"";
/// 图片服务器地址
NSString * const GQHPictureServerURL = @"";
/// 文件服务器地址
NSString * const GQHFileServerURL = @"";
#endif

/// 空白页链接
NSString * const GQHBlankURL = @"about:blank";


#pragma mark - business
/// 分页每页大小
NSInteger const GQHPageSize = 10;

/// 游戏图片
NSString * const GQHGameImageKey = @"game_image";
/// 游戏等级(阶数)
NSString * const GQHGameLevelOrderKey = @"game_level_order";
/// 游戏等级(标题)
NSString * const GQHGameLevelTitleKey = @"game_level_title";
/// 游戏音效
NSString * const GQHGameSoundKey = @"game_sound";
/// 游戏记录
NSString * const GQHGameRecordKey = @"game_record";


#pragma mark - assets
/// NavigationBar
NSString * const GQHNavigationBarBackArrowBlackOnClear = @"NavigationBarBackArrowBlackOnClear";
NSString * const GQHNavigationBarBackArrowWhiteOnBlack = @"NavigationBarBackArrowWhiteOnBlack";
NSString * const GQHNavigationBarBackArrowWhiteOnClear = @"NavigationBarBackArrowWhiteOnClear";
NSString * const GQHNavigationBarResetBlackOnClear = @"NavigationBarResetBlackOnClear";


@implementation GQHConstantHelper

@end
