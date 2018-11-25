//
//  GQHGIFPreviewCell.m
//  GQHKit
//
//  Created by GuanQinghao on 07/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHGIFPreviewCell.h"
#import "GQHPhotoPreviewView.h"

@implementation GQHGIFPreviewCell

- (void)qh_configureSubviews {
    
    _qh_previewView = [[GQHPhotoPreviewView alloc] initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf = self;
    [_qh_previewView setSingleTapGestureBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [strongSelf singleTapAction];
    }];
    
    [self addSubview:_qh_previewView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _qh_previewView.frame = self.bounds;
}

- (void)singleTapAction {
    
    if (self.singleTapGestureBlock) {
        
        self.singleTapGestureBlock();
    }
}

- (void)setQh_assetModel:(GQHAssetModel *)qh_assetModel {
    
    [super setQh_assetModel:qh_assetModel];
    _qh_previewView.qh_assetModel = self.qh_assetModel;
}

@end
