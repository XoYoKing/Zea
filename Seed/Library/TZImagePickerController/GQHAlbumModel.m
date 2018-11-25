//
//  GQHAlbumModel.m
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAlbumModel.h"
#import "GQHAssetModel.h"
#import "GQHImageManager.h"

@implementation GQHAlbumModel

- (void)setQh_result:(PHFetchResult *)qh_result {
    
    _qh_result = qh_result;
    [[GQHImageManager qh_manager] qh_fetchAssetsFromResult:qh_result completion:^(NSArray<GQHAssetModel *> *assetModelArray) {
        
        _qh_assetModelArray = assetModelArray;
        if (_qh_selectedAssetModelArray) {
            
            [self checkSelectedAssetModelCount];
        }
    }];
}

- (void)setQh_selectedAssetModelArray:(NSArray<GQHAssetModel *> *)qh_selectedAssetModelArray {
    
    _qh_selectedAssetModelArray = qh_selectedAssetModelArray;
    if (_qh_assetModelArray) {
        
        [self checkSelectedAssetModelCount];
    }
}

- (void)checkSelectedAssetModelCount {
    
    self.qh_selectedAssetModelCount = 0;
    
    NSMutableArray<PHAsset *> *selectedAssetArray = [NSMutableArray array];
    for (GQHAssetModel *assetModel in _qh_selectedAssetModelArray) {
        
        [selectedAssetArray addObject:assetModel.qh_asset];
    }
    for (GQHAssetModel *assetModel in _qh_assetModelArray) {
        
        if ([[GQHImageManager qh_manager] qh_containsAsset:assetModel.qh_asset withinAssetArray:selectedAssetArray]) {
            
            self.qh_selectedAssetModelCount++;
        }
    }
}

- (NSString *)qh_albumName {
    
    if (_qh_albumName) {
        
        return _qh_albumName;
    }
    
    return @"";
}

@end
