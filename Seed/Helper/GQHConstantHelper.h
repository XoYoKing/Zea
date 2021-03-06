//
//  GQHConstantHelper.h
//  Seed
//
//  Created by GuanQinghao on 2018/6/16.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - color
/// #C8351A
UIKIT_EXTERN NSString * const GQHColorFireBrick;
/// #E48978
UIKIT_EXTERN NSString * const GQHColorDarkSalmon;
/// #C0C0C0
UIKIT_EXTERN NSString * const GQHColorSilver;
/// #F8F8F8
UIKIT_EXTERN NSString * const GQHColorWhiteSmoke;


#pragma mark - font color
/// 黑色 #111111
UIKIT_EXTERN NSString * const GQHFontColorBlack;
/// 深黑色 #333333
UIKIT_EXTERN NSString * const GQHFontColorDarkBlack;
/// 深灰色 #666666
UIKIT_EXTERN NSString * const GQHFontColorDarkGray;
/// 灰色 #999999
UIKIT_EXTERN NSString * const GQHFontColorGray;
/// 浅灰色 #CCCCCC
UIKIT_EXTERN NSString * const GQHFontColorLightGray;
/// 白色 #FFFFFF
UIKIT_EXTERN NSString * const GQHFontColorWhite;


#pragma mark - font size
/// 正文、列表正文
UIKIT_EXTERN CGFloat const GQHFontSizeSmallest;
/// 副文、列表副文
UIKIT_EXTERN CGFloat const GQHFontSizeSmaller;
/// 最小字体 小字
UIKIT_EXTERN CGFloat const GQHFontSizeDefault;
/// 标题、按钮
UIKIT_EXTERN CGFloat const GQHFontSizeBigger;
/// 最大字体 导航、突出内容
UIKIT_EXTERN CGFloat const GQHFontSizeBiggest;


#pragma mark - font name
/// 苹方-简 中黑体
UIKIT_EXTERN NSString * const GQHFontNamePFSMedium;
/// 苹方-简 中粗体
UIKIT_EXTERN NSString * const GQHFontNamePFSSemibold;
/// 苹方-简 常规体
UIKIT_EXTERN NSString * const GQHFontNamePFSRegular;


#pragma mark - UI
/// 全局常量-间距
UIKIT_EXTERN CGFloat const GQHSpacing;
/// 全局常量-单倍外边距
UIKIT_EXTERN CGFloat const GQHSingleMargin;
/// 全局常量-双倍外边距
UIKIT_EXTERN CGFloat const GQHDoubleMargin;
/// 全局常量-线的粗细
UIKIT_EXTERN CGFloat const GQHLineWidth;
/// 视图布局最小尺寸
UIKIT_EXTERN CGFloat const GQHLayoutMinValue;
/// 普通按钮高度
UIKIT_EXTERN CGFloat const GQHButtonNormalHeight;
/// UI圆角
UIKIT_EXTERN CGFloat const GQHUICornerRadius;


#pragma makr - network
/// 成功code 1
UIKIT_EXTERN NSInteger const GQHHTTPStatusOKCode;
/// 服务器错误code 500
UIKIT_EXTERN NSInteger const GQHHTTPStatusServiceErrorCode;
/// 无服务code 503
UIKIT_EXTERN NSInteger const GQHHTTPStatusNoServiceCode;
/// 无效的令牌code 401
UIKIT_EXTERN NSInteger const GQHHTTPStatusUnauthorizedCode;

/// 接口根域名地址
UIKIT_EXTERN NSString * const GQHAPIServerBaseURL;
/// 接口路径地址
UIKIT_EXTERN NSString * const GQHAPIPathURL;
/// 图片服务器地址
UIKIT_EXTERN NSString * const GQHPictureServerURL;
/// 文件服务器地址
UIKIT_EXTERN NSString * const GQHFileServerURL;
/// 空白页链接
UIKIT_EXTERN NSString * const GQHBlankURL;


#pragma mark - business
//MARK:database
/// 数据库文件名
UIKIT_EXTERN NSString * const GQHDatabaseFileName;
/// 数据库版本号Key
UIKIT_EXTERN NSString * const GQHDatabaseVersionKey;
/// 图库表
UIKIT_EXTERN NSString * const GQHDatabaseGalleryTable;
/// 等级表
UIKIT_EXTERN NSString * const GQHDatabaseLevelTable;
/// 菜单表
UIKIT_EXTERN NSString * const GQHDatabaseMenuTable;
/// 记录表
UIKIT_EXTERN NSString * const GQHDatabaseRecordTable;





/// 分页每页大小
UIKIT_EXTERN NSInteger const GQHPageSize;

/// 游戏图片
UIKIT_EXTERN NSString * const GQHGameImageKey;
/// 游戏等级(阶数)
UIKIT_EXTERN NSString * const GQHGameLevelOrderKey;
/// 游戏等级(标题)
UIKIT_EXTERN NSString * const GQHGameLevelTitleKey;
/// 游戏音效
UIKIT_EXTERN NSString * const GQHGameSoundKey;
/// 游戏记录
UIKIT_EXTERN NSString * const GQHGameRecordKey;


#pragma mark - assets
/// NavigationBar
UIKIT_EXTERN NSString * const GQHNavigationBarBackArrowBlackOnClear;
UIKIT_EXTERN NSString * const GQHNavigationBarBackArrowWhiteOnBlack;
UIKIT_EXTERN NSString * const GQHNavigationBarBackArrowWhiteOnClear;
UIKIT_EXTERN NSString * const GQHNavigationBarResetBlackOnClear;


NS_ASSUME_NONNULL_BEGIN

@interface GQHConstantHelper : NSObject

@end

NS_ASSUME_NONNULL_END
