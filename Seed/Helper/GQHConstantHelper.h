//
//  GQHConstantHelper.h
//  Seed
//
//  Created by GuanQinghao on 2018/6/16.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
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

@end


