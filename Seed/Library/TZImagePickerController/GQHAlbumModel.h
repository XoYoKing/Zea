//
//  GQHAlbumModel.h
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GQHAssetModel, PHFetchResult;
@interface GQHAlbumModel : NSObject

// 专辑名称
@property (nonatomic, copy) NSString *qh_albumName; // The album name

// 某专辑下资源个数 (相册下照片的数量)
@property (nonatomic, assign) NSUInteger qh_assetCount; // Count of assets the album contains

// 查询结果 PHFetchResult<PHAsset>
@property (nonatomic, strong) PHFetchResult *qh_result;

// 某专辑下资源模型数组
@property (nonatomic, strong) NSArray<GQHAssetModel *> *qh_assetModelArray;

// 选中的资源模型数组
@property (nonatomic, strong) NSArray<GQHAssetModel *> *qh_selectedAssetModelArray;

// 选中的资源模型个数
@property (nonatomic, assign) NSUInteger qh_selectedAssetModelCount;

// 相机胶卷
@property (nonatomic, assign) BOOL qh_isCameraRoll;

@end
