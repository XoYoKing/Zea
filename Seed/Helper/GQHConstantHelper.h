//
//  GQHConstantHelper.h
//  Seed
//
//  Created by GuanQinghao on 2018/6/16.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 游戏等级
typedef NS_ENUM(NSInteger, GQHUserLevel) {
    
    GQHUserLevelEasy    = 3,
    GQHUserLevelNormal  = 4,
    GQHUserLevelHarder  = 6,
    GQHUserLevelHardest = 8     /// Only in iPad
};


/// 游戏图片
UIKIT_EXTERN NSString * const GQHUserImageKey;
/// 游戏等级
UIKIT_EXTERN NSString * const GQHUserLevelKey;
/// 游戏音效
UIKIT_EXTERN NSString * const GQHUserSoundKey;
/// 游戏记录
UIKIT_EXTERN NSString * const GQHUserRecordKey;



@interface GQHConstantHelper : NSObject

+ (nonnull NSString *)qh_imagesDirectoryPath;



#pragma mark - color


#pragma mark - font color
/// 黑色 #111111
UIKIT_EXTERN NSString * const GQHFontColorBlack;
/// 深黑色 #333333
UIKIT_EXTERN NSString * const GQHFontColorDarkBlack;
/// 灰色 #999999
UIKIT_EXTERN NSString * const GQHFontColorGray;
/// 浅灰色 #adadad
UIKIT_EXTERN NSString * const GQHFontColorLightGray;
/// 白色 #ffffff
UIKIT_EXTERN NSString * const GQHFontColorWhite;


#pragma mark - font size
/// 正文、列表正文
UIKIT_EXTERN CGFloat const GQHSmallestFont;
/// 副文、列表副文
UIKIT_EXTERN CGFloat const GQHSmallerFont;
/// 最小字体 小字
UIKIT_EXTERN CGFloat const GQHDefaultFont;
/// 标题、按钮
UIKIT_EXTERN CGFloat const GQHBiggerFont;
/// 最大字体 导航、突出内容
UIKIT_EXTERN CGFloat const GQHBiggestFont;

#pragma mark - font name
/// 苹方-简 中黑体
UIKIT_EXTERN NSString * const GQHFontNamePFSMedium;
/// 苹方-简 中粗体
UIKIT_EXTERN NSString * const GQHFontNamePFSSemibold;
/// 苹方-简 常规体
UIKIT_EXTERN NSString * const GQHFontNamePFSRegular;


#pragma mark - UI参数
/// 全局常量-单倍外边距
UIKIT_EXTERN CGFloat const GQHSingleMargin;
/// 全局常量-双倍外边距
UIKIT_EXTERN CGFloat const GQHDoubleMargin;
/// 全局常量-线的粗细
UIKIT_EXTERN CGFloat const GQHLineWidth;
/// 视图布局最小尺寸
UIKIT_EXTERN CGFloat const GQHMinLayoutSize;
/// 普通按钮高度
UIKIT_EXTERN CGFloat const GQHButtonNormalHeight;


#pragma makr - 网络请求
/// 成功code 1
UIKIT_EXTERN NSInteger const GQHHTTPStatusOKCode;
/// 无服务code 503
UIKIT_EXTERN NSInteger const GQHHTTPStatusNoServiceCode;
/// 无效的令牌code 101
UIKIT_EXTERN NSInteger const GQHHTTPStatusUnauthorizedCode;


#pragma mark - 业务参数
/// 接口根域名地址
UIKIT_EXTERN NSString * const GQHAPIServerBaseURL;
/// 接口路径地址
UIKIT_EXTERN NSString * const GQHAPIPathURL;
/// 图片服务器地址
UIKIT_EXTERN NSString * const GQHPictureServerURL;
/// 文件服务器地址
UIKIT_EXTERN NSString * const GQHFileServerURL;
/// 百度地图AppKey
UIKIT_EXTERN NSString * const GQHBMKAppKey;


#pragma mark - 图片资源名称
/// TabBar
UIKIT_EXTERN NSString * const GQHTabBarItemHomeNormal;
UIKIT_EXTERN NSString * const GQHTabBarItemHomeSelected;
UIKIT_EXTERN NSString * const GQHTabBarItemAttendanceNormal;
UIKIT_EXTERN NSString * const GQHTabBarItemAttendanceSelected;
UIKIT_EXTERN NSString * const GQHTabBarItemMeNormal;
UIKIT_EXTERN NSString * const GQHTabBarItemMeSelected;
UIKIT_EXTERN NSString * const GQHTabBarItemNew;

/// NavigationBar
UIKIT_EXTERN NSString * const GQHNavigationBarLeftArrowWhite;
UIKIT_EXTERN NSString * const GQHNavigationBarLeftArrowBlack;
UIKIT_EXTERN NSString * const GQHNavigationBarBackArrowBlack;

/// Me
UIKIT_EXTERN NSString * const GQHMeAppFeedbackAddPicture;
UIKIT_EXTERN NSString * const GQHMeAppFeedbackRemovePicture;
UIKIT_EXTERN NSString * const GQHMeAppAbout;
UIKIT_EXTERN NSString * const GQHMeAppFeedback;
UIKIT_EXTERN NSString * const GQHMeAppQA;
UIKIT_EXTERN NSString * const GQHMeArrowRight;
UIKIT_EXTERN NSString * const GQHMeDefaultAvatar;
UIKIT_EXTERN NSString * const GQHMeProjects;

/// Login
UIKIT_EXTERN NSString * const GQHLoginEyeOff;
UIKIT_EXTERN NSString * const GQHLoginEyeOn;

/// Home
UIKIT_EXTERN NSString * const GQHHomeTriangleDown;
UIKIT_EXTERN NSString * const GQHHomeBannerBackgroundImage;
UIKIT_EXTERN NSString * const GQHHomeMenuBadgeBackgroundImage;
UIKIT_EXTERN NSString * const GQHHomeMenuBackgroundImage;

@end
