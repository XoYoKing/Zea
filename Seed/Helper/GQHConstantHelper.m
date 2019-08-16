//
//  GQHConstantHelper.m
//  Seed
//
//  Created by GuanQinghao on 2018/6/16.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHConstantHelper.h"


/// 游戏图片
NSString * const GQHUserImageKey = @"user_image";
/// 游戏等级
NSString * const GQHUserLevelKey = @"user_level";
/// 游戏音效
NSString * const GQHUserSoundKey = @"user_sound";
/// 游戏记录
NSString * const GQHUserRecordKey = @"user_record";


#pragma mark - color


#pragma mark - font color
NSString * const GQHFontColorBlack = @"#111111";
NSString * const GQHFontColorDarkBlack = @"#333333";
NSString * const GQHFontColorGray = @"#999999";
NSString * const GQHFontColorLightGray = @"#adadad";
NSString * const GQHFontColorWhite = @"#FFFFFF"; 


#pragma mark - font size
CGFloat const GQHSmallestFont = 10.0f;
CGFloat const GQHSmallerFont = 14.0f;
CGFloat const GQHDefaultFont = 16.0f;
CGFloat const GQHBiggerFont = 18.0f;
CGFloat const GQHBiggestFont = 20.0f;

#pragma mark - font name
NSString * const GQHFontNamePFSMedium = @"PingFangSC-Medium";
NSString * const GQHFontNamePFSSemibold = @"PingFangSC-Semibold";
NSString * const GQHFontNamePFSRegular = @"PingFangSC-Regular";

#pragma mark - UI参数
CGFloat const GQHSingleMargin = 15.0f;
CGFloat const GQHDoubleMargin = 2 * GQHSingleMargin;
CGFloat const GQHLineWidth = 1.0f;
CGFloat const GQHMinLayoutSize = 10.0f;
CGFloat const GQHButtonNormalHeight = 44.0f;

#pragma makr - 网络请求
NSInteger const GQHHTTPStatusOKCode = 1;
NSInteger const GQHHTTPStatusNoServiceCode = 503;
NSInteger const GQHHTTPStatusUnauthorizedCode = 101;


#pragma mark - 业务参数
NSString * const GQHAPIServerBaseURL = @"";
//NSString * const GQHAPIPathURL = @"https://1chalk.com/mall-app";
NSString * const GQHAPIPathURL = @"http://192.168.1.38:8109/app-cloud";
NSString * const GQHPictureServerURL = @"https://1chalk.com/";
NSString * const GQHFileServerURL = @"https://1chalk.com/";
NSString * const GQHBMKAppKey = @"8DqmxnnK2bjewy9G3Tk9uPqqbh9AaDZA";

#pragma mark - 图片资源名称
/// TabBar
NSString * const GQHTabBarItemHomeNormal = @"TabBarItemHomeNormal";
NSString * const GQHTabBarItemHomeSelected = @"TabBarItemHomeSelected";
NSString * const GQHTabBarItemAttendanceNormal = @"TabBarItemAttendanceNormal";
NSString * const GQHTabBarItemAttendanceSelected = @"TabBarItemAttendanceSelected";
NSString * const GQHTabBarItemMeNormal = @"TabBarItemMeNormal";
NSString * const GQHTabBarItemMeSelected = @"TabBarItemMeSelected";
NSString * const GQHTabBarItemNew = @"TabBarItemNew";

/// NavigationBar
NSString * const GQHNavigationBarLeftArrowWhite = @"NavigationBarLeftArrowWhite";
NSString * const GQHNavigationBarLeftArrowBlack = @"NavigationBarLeftArrowBlack";
NSString * const GQHNavigationBarBackArrowBlack = @"NavigationBarBackArrowBlack";

/// Me
NSString * const GQHMeAppFeedbackAddPicture = @"MeAppFeedbackAddPicture";
NSString * const GQHMeAppFeedbackRemovePicture = @"MeAppFeedbackRemovePicture";
NSString * const GQHMeAppAbout = @"MeAppAbout";
NSString * const GQHMeAppFeedback = @"MeAppFeedback";
NSString * const GQHMeAppQA = @"MeAppQA";
NSString * const GQHMeArrowRight = @"MeArrowRight";
NSString * const GQHMeDefaultAvatar = @"MeDefaultAvatar";
NSString * const GQHMeProjects = @"MeProjects";

/// Login
NSString * const GQHLoginEyeOff = @"LoginEyeOff";
NSString * const GQHLoginEyeOn = @"LoginEyeOn";

/// Home
NSString * const GQHHomeTriangleDown = @"HomeTriangleDown";
NSString * const GQHHomeBannerBackgroundImage = @"HomeBannerBackgroundImage";
NSString * const GQHHomeMenuBadgeBackgroundImage = @"HomeMenuBadgeBackgroundImage";
NSString * const GQHHomeMenuBackgroundImage = @"HomeMenuBackgroundImage";

@implementation GQHConstantHelper

+ (nonnull NSString *)qh_imagesDirectoryPath {
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    return [NSString stringWithFormat:@"%@/pictures",cachesPath];
}

@end
