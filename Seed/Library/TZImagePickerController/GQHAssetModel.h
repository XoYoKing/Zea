//
//  GQHAssetModel.h
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GQHAssetModelMediaTypePhoto,      // 照片
    GQHAssetModelMediaTypeLivePhoto,  // 现场照片
    GQHAssetModelMediaTypeGIFPhoto,   // 动态图
    GQHAssetModelMediaTypeVideo,      // 视频
    GQHAssetModelMediaTypeAudio       // 音频
} GQHAssetModelMediaType;


@class PHAsset;
@interface GQHAssetModel : NSObject

// PHAsset
@property (nonatomic, strong) PHAsset *qh_asset;

// 资源(asset)选中状态 默认为NO
@property (nonatomic, assign) BOOL qh_isSelected;

// 资源(asset)类型
@property (nonatomic, assign) GQHAssetModelMediaType qh_MediaType;

// 视频、音频、动态图等的时长
@property (nonatomic, copy) NSString *qh_duration;


// 用PHAsset实例初始化一个模型
+ (instancetype)qh_modelWithAsset:(PHAsset *)asset mediaType:(GQHAssetModelMediaType)mediaType;

// 用PHAsset实例初始化一个模型(时长)
+ (instancetype)qh_modelWithAsset:(PHAsset *)asset mediaType:(GQHAssetModelMediaType)mediaType duration:(NSString *)duration;

@end
