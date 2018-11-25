//
//  GQHAssetModel.m
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAssetModel.h"

@implementation GQHAssetModel

+ (instancetype)qh_modelWithAsset:(PHAsset *)asset mediaType:(GQHAssetModelMediaType)mediaType {
    
    GQHAssetModel *assetModel = [[GQHAssetModel alloc] init];
    assetModel.qh_asset = asset;
    assetModel.qh_isSelected = NO;
    assetModel.qh_MediaType = mediaType;
    
    return assetModel;
}

+ (instancetype)qh_modelWithAsset:(PHAsset *)asset mediaType:(GQHAssetModelMediaType)mediaType duration:(NSString *)duration {
    
    GQHAssetModel *assetModel = [self qh_modelWithAsset:asset mediaType:mediaType];
    assetModel.qh_duration = duration;
    
    return assetModel;
}

@end
