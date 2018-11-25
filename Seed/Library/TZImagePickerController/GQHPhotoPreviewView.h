//
//  GQHPhotoPreviewView.h
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class GQHProgressView,GQHAssetModel;
@interface GQHPhotoPreviewView : UIView

//
@property (nonatomic, strong) UIImageView *qh_imageView;

//
@property (nonatomic, strong) UIScrollView *qh_previewScrollView;

//
@property (nonatomic, strong) UIView *qh_imageContainerView;

//
@property (nonatomic, strong) GQHProgressView *qh_progressView;

//
@property (nonatomic, assign) BOOL qh_canCrop;

//
@property (nonatomic, assign) CGRect qh_cropRect;

//
@property (nonatomic, strong) GQHAssetModel *qh_assetModel;

//
@property (nonatomic, strong) PHAsset *qh_asset;

//
@property (nonatomic, copy) void (^singleTapGestureBlock)(void);

//
@property (nonatomic, copy) void (^imageProgressUpdateBlock)(double progress);

//
@property (nonatomic, assign) int32_t qh_imageRequestID;// PHImageRequestID


// 重置子视图
- (void)qh_resetSubviews;

@end
