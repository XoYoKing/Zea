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


@implementation GQHConstantHelper

+ (nonnull NSString *)qh_imagesDirectoryPath {
    
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    
    return [NSString stringWithFormat:@"%@/pictures",cachesPath];
}

@end
