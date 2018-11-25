//
//  GQHPhotoPreviewCell.h
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAssetPreviewCell.h"

@class GQHProgressView,GQHPhotoPreviewView;
@interface GQHPhotoPreviewCell : GQHAssetPreviewCell

// 相册预览视图
@property (nonatomic, strong) GQHPhotoPreviewView *qh_photoPreviewView;

// 是否可以裁剪
@property (nonatomic, assign) BOOL qh_canCrop;

// 裁剪范围
@property (nonatomic, assign) CGRect qh_cropRect;

// 图片加载进度
@property (nonatomic, copy) void (^imageProgressUpdateBlock)(double progress);

// 重置子视图
- (void)qh_resetSubviews;

@end
