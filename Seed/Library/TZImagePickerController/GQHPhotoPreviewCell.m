//
//  GQHPhotoPreviewCell.m
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHPhotoPreviewCell.h"
#import "GQHPhotoPreviewView.h"
#import "GQHAssetModel.h"

@implementation GQHPhotoPreviewCell

// 重置子视图
- (void)qh_resetSubviews {
    
    [_qh_photoPreviewView qh_resetSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.qh_photoPreviewView.frame = self.bounds;
}

#pragma mark --Setter
- (void)setQh_assetModel:(GQHAssetModel *)qh_assetModel {
    
    [super setQh_assetModel:qh_assetModel];
    _qh_photoPreviewView.qh_asset = qh_assetModel.qh_asset;
}

- (void)setQh_canCrop:(BOOL)qh_canCrop {
    
    _qh_canCrop = qh_canCrop;
    _qh_photoPreviewView.qh_canCrop = qh_canCrop;
}

- (void)setQh_cropRect:(CGRect)qh_cropRect {
    
    _qh_cropRect = qh_cropRect;
    _qh_photoPreviewView.qh_cropRect = qh_cropRect;
}

#pragma mark --ParentMethod 父类方法
// 设置子视图
- (void)qh_configureSubviews {
    
    self.qh_photoPreviewView = [[GQHPhotoPreviewView alloc] initWithFrame:CGRectZero];
    
    __weak typeof(self) weakSelf = self;
    [self.qh_photoPreviewView setSingleTapGestureBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.singleTapGestureBlock) {
            
            strongSelf.singleTapGestureBlock();
        }
    }];
    
    [self.qh_photoPreviewView setImageProgressUpdateBlock:^(double progress) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.imageProgressUpdateBlock) {
            
            strongSelf.imageProgressUpdateBlock(progress);
        }
    }];
    
    [self addSubview:self.qh_photoPreviewView];
}

@end
