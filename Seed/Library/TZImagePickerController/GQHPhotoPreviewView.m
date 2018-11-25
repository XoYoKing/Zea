//
//  GQHPhotoPreviewView.m
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHPhotoPreviewView.h"
#import "GQHImageManager.h"
#import "GQHProgressView.h"
#import "GQHAssetModel.h"
#import "UIImage+GQHGIF.h"

@interface GQHPhotoPreviewView () <UIScrollViewDelegate>

@end


@implementation GQHPhotoPreviewView

#pragma mark --Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _qh_previewScrollView = [[UIScrollView alloc] init];
        _qh_previewScrollView.bouncesZoom = YES;
        _qh_previewScrollView.maximumZoomScale = 2.5f;
        _qh_previewScrollView.minimumZoomScale = 1.0f;
        _qh_previewScrollView.multipleTouchEnabled = YES;
        _qh_previewScrollView.delegate = self;
        _qh_previewScrollView.scrollsToTop = NO;
        _qh_previewScrollView.showsHorizontalScrollIndicator = NO;
        _qh_previewScrollView.showsVerticalScrollIndicator = YES;
        _qh_previewScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _qh_previewScrollView.delaysContentTouches = NO;
        _qh_previewScrollView.canCancelContentTouches = YES;
        _qh_previewScrollView.alwaysBounceVertical = NO;
        [self addSubview:_qh_previewScrollView];
        
        _qh_imageContainerView = [[UIView alloc] init];
        _qh_imageContainerView.clipsToBounds = YES;
        _qh_imageContainerView.contentMode = UIViewContentModeScaleAspectFill;
        [_qh_previewScrollView addSubview:_qh_imageContainerView];
        
        _qh_imageView = [[UIImageView alloc] init];
        _qh_imageView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
        _qh_imageView.contentMode = UIViewContentModeScaleAspectFill;
        _qh_imageView.clipsToBounds = YES;
        [_qh_imageContainerView addSubview:_qh_imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        doubleTap.numberOfTapsRequired = 2;
        [tap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:doubleTap];
        
        [self configureProgressView];
    }
    return self;
}

- (void)configureProgressView {
    
    _qh_progressView = [[GQHProgressView alloc] init];
    _qh_progressView.hidden = YES;
    [self addSubview:_qh_progressView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _qh_previewScrollView.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
    static CGFloat progressWidth = 40.0f;
    static CGFloat progressHeight = 40.0f;
    CGFloat progressX = 0.5 * (self.frame.size.width - progressWidth);
    CGFloat progressY = 0.5 * (self.frame.size.height - progressHeight);
    _qh_progressView.frame = CGRectMake(progressX, progressY, progressWidth, progressHeight);
    
    [self qh_resetSubviews];
}

// 重置子视图
- (void)qh_resetSubviews {
    
    [_qh_previewScrollView setZoomScale:1.0f animated:NO];
    [self resizeSubviews];
}

#pragma mark --EventMethod
- (IBAction)click:(UITapGestureRecognizer *)sender {
    
    if (self.singleTapGestureBlock) {
        
        self.singleTapGestureBlock();
    }
}

- (IBAction)doubleClick:(UITapGestureRecognizer *)sender {
    
    if (_qh_previewScrollView.zoomScale > 1.0) {
        
        _qh_previewScrollView.contentInset = UIEdgeInsetsZero;
        [_qh_previewScrollView setZoomScale:1.0 animated:YES];
    } else {
        
        CGPoint touchPoint = [sender locationInView:self.qh_imageView];
        CGFloat scale = _qh_previewScrollView.maximumZoomScale;
        CGFloat x = self.frame.size.width / scale;
        CGFloat y = self.frame.size.height / scale;
        [_qh_previewScrollView zoomToRect:CGRectMake(touchPoint.x - 0.5 * x, touchPoint.y - 0.5 * y, x, y) animated:YES];
    }
    
}

#pragma mark --Setter
- (void)setQh_assetModel:(GQHAssetModel *)qh_assetModel {
    
    _qh_assetModel = qh_assetModel;
    [_qh_previewScrollView setZoomScale:1.0f animated:NO];
    
    if (qh_assetModel.qh_MediaType == GQHAssetModelMediaTypeGIFPhoto) {
        
        // 先显示缩略图
        [[GQHImageManager qh_manager] qh_fetchPhotoWithAsset:qh_assetModel.qh_asset networkAccessAllowed:NO progressHandler:nil completionHandler:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            
            self.qh_imageView.image = photo;
            [self resizeSubviews];
            
            // 再显示GIF图
            [[GQHImageManager qh_manager] qh_fetchOriginalPhotoDataWithAsset:qh_assetModel.qh_asset completionHandler:^(NSData *data, NSDictionary *info, BOOL isDegraded) {
                
                if (!isDegraded) {
                    
                    self.qh_imageView.image = [UIImage qh_animateGIFWithData:data];
                    [self resizeSubviews];
                }
            }];
        }];
    } else {
        
        self.qh_asset = qh_assetModel.qh_asset;
    }
}

- (void)setQh_asset:(PHAsset *)qh_asset {
    
    if (_qh_asset && self.qh_imageRequestID) {
        
        [[PHImageManager defaultManager] cancelImageRequest:self.qh_imageRequestID];
    }
    
    _qh_asset = qh_asset;
    self.qh_imageRequestID = [[GQHImageManager qh_manager] qh_fetchPhotoWithAsset:qh_asset networkAccessAllowed:YES progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        
        if (![qh_asset isEqual:_qh_asset]) {
            
            return ;
        }
        
        _qh_progressView.hidden = NO;
        [self bringSubviewToFront:_qh_progressView];
        
        progress = progress > 0.02 ? progress : 0.02;
        _qh_progressView.qh_progress = progress;
        
        if (self.imageProgressUpdateBlock && progress < 1) {
            
            self.imageProgressUpdateBlock(progress);
        }
        
        if (progress >= 1) {
            
            _qh_progressView.hidden = YES;
            self.qh_imageRequestID = 0;
        }
    } completionHandler:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        if (![qh_asset isEqual:qh_asset]) {
            
            return;
        }
        self.qh_imageView.image = photo;
        [self resizeSubviews];
        
        _qh_progressView.hidden = YES;
        
        if (self.imageProgressUpdateBlock) {
            self.imageProgressUpdateBlock(1.0);
        }
        
        if (!isDegraded) {
            
            self.qh_imageRequestID = 0;
        }
    }];
}

- (void)setQh_canCrop:(BOOL)qh_canCrop {
    
    qh_canCrop = qh_canCrop;
    _qh_previewScrollView.maximumZoomScale = qh_canCrop ? 4.0 : 2.5;
    
    CGFloat aspectRatio = _qh_asset.pixelWidth / (CGFloat)_qh_asset.pixelHeight;
    
    // 优化超宽图片
    if (aspectRatio > 1.5) {
        
        self.qh_previewScrollView.maximumZoomScale *= aspectRatio / 1.5;
    }
}

#pragma mark --UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _qh_imageContainerView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    [self resetImageContainerViewCenter];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
    [self resetScrollViewContentSize];
}


#pragma mark --PrivateMethod
- (void)resizeSubviews {
    
    _qh_imageContainerView.qh_originPoint = CGPointZero;
    _qh_imageContainerView.qh_width = self.qh_previewScrollView.qh_width;
    
    UIImage *image = _qh_imageView.image;
    if (image.size.height / image.size.width > self.qh_height / self.qh_previewScrollView.qh_width) {
        
        _qh_imageContainerView.qh_height = floor(image.size.height / (image.size.width / self.qh_previewScrollView.qh_width));
    } else {
        
        CGFloat height = image.size.height / image.size.width * self.qh_previewScrollView.qh_width;
        if (height < 1 || isnan(height)) {
            
            height = self.qh_height;
        }
        height = floor(height);
        _qh_imageContainerView.qh_height = height;
        _qh_imageContainerView.qh_centerY = 0.5 * self.qh_height;
    }
    if (_qh_imageContainerView.qh_height > self.qh_height && _qh_imageContainerView.qh_height - self.qh_height <= 1) {
        
        _qh_imageContainerView.qh_height = self.qh_height;
    }
    CGFloat contentSizeHeight = MAX(_qh_imageContainerView.qh_height, self.qh_height);
    _qh_previewScrollView.contentSize = CGSizeMake(self.qh_previewScrollView.qh_width, contentSizeHeight);
    [_qh_previewScrollView scrollRectToVisible:self.bounds animated:NO];
    _qh_previewScrollView.alwaysBounceVertical = _qh_imageContainerView.qh_height <= self.qh_height ? NO : YES;
    _qh_imageView.frame = _qh_imageContainerView.bounds;
    
    [self resetScrollViewContentSize];
}

- (void)resetScrollViewContentSize {
    
    if (_qh_canCrop) {
        
        CGFloat expandedContentWidth = self.qh_previewScrollView.qh_width - CGRectGetMaxX(_qh_cropRect);
        CGFloat expandedContentHeight = 0.5 * (MIN(_qh_imageContainerView.qh_height, self.qh_height) - self.qh_cropRect.size.height);
        
        CGFloat contentWidth = self.qh_previewScrollView.contentSize.width + expandedContentWidth;
        CGFloat contentHeight = MAX(self.qh_previewScrollView.contentSize.height, self.qh_height) + expandedContentHeight;
        _qh_previewScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
        _qh_previewScrollView.alwaysBounceVertical = YES;
        
        if (expandedContentHeight > 0 || expandedContentWidth > 0) {
            
            _qh_previewScrollView.contentInset = UIEdgeInsetsMake(expandedContentHeight, _qh_cropRect.origin.x, 0, 0);
        } else {
            
            _qh_previewScrollView.contentInset = UIEdgeInsetsZero;
        }
    }
}

- (void)resetImageContainerViewCenter {
    
    CGFloat offsetX = (_qh_previewScrollView.frame.size.width > _qh_previewScrollView.contentSize.width)
    ? 0.5 * (_qh_previewScrollView.frame.size.width - _qh_previewScrollView.contentSize.width) : 0.0f;
    CGFloat offsetY = (_qh_previewScrollView.frame.size.height > _qh_previewScrollView.contentSize.height) ? 0.5 * (_qh_previewScrollView.frame.size.height - _qh_previewScrollView.contentSize.height) : 0.0f;
    
    self.qh_imageContainerView.center = CGPointMake(0.5 * _qh_previewScrollView.contentSize.width + offsetX, 0.5 * _qh_previewScrollView.contentSize.height + offsetY);
}

@end
