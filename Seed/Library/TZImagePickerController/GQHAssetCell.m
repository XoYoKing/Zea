//
//  GQHAssetCell.m
//  GQHKit
//
//  Created by GuanQinghao on 07/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAssetCell.h"
#import "GQHAssetModel.h"
#import "GQHProgressView.h"
#import "GQHImageManager.h"
#import "UIView+GQHAnimation.h"
#import <Photos/Photos.h>

@interface GQHAssetCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *selectedImageView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) GQHProgressView *progressView;
@property (nonatomic, assign) int32_t originalImageRequestID;

@end


@implementation GQHAssetCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.qh_canPreview) {
        
        _qh_selectButton.frame = CGRectMake(self.frame.size.width - 44, 0, 44, 44);
    } else {
        
        _qh_selectButton.frame = self.bounds;
    }
    _selectedImageView.frame = CGRectMake(self.frame.size.width - 27, 0, 27, 27);
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    static CGFloat progressWidth = 20;
    static CGFloat progressHeight = 20;
    CGFloat progressX = 0.5 * (self.frame.size.width - progressWidth);
    CGFloat progressY = 0.5 * (self.frame.size.height - progressHeight);
    
    _progressView.frame = CGRectMake(progressX, progressY, progressWidth, progressHeight);
    _bottomView.frame = CGRectMake(0, self.frame.size.height - 17, self.frame.size.width, 17);
    _videoImageView.frame = CGRectMake(8, 0, 17, 17);
    _timeLabel.frame = CGRectMake(CGRectGetMaxX(self.videoImageView.frame), 0, self.frame.size.width - CGRectGetMaxX(self.videoImageView.frame) - 5, 17);
    
    self.qh_cellType = (NSUInteger)self.qh_assetModel.qh_MediaType;
    self.qh_showSelectButton = self.qh_showSelectButton;
}

- (void)setQh_assetModel:(GQHAssetModel *)qh_assetModel {
    
    _qh_assetModel = qh_assetModel;
    
    self.qh_representedAssetIdentifier = qh_assetModel.qh_asset.localIdentifier;
    int32_t imageRequestID = [[GQHImageManager qh_manager] qh_fetchPhotoWithAsset:qh_assetModel.qh_asset photoWidth:self.frame.size.width networkAccessAllowed:NO progressHandler:nil completionHandler:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        if (_progressView) {
            
            self.progressView.hidden = YES;
            self.imageView.alpha = 1.0;
        }
        
        if ([self.qh_representedAssetIdentifier isEqualToString:qh_assetModel.qh_asset.localIdentifier]) {
            
            self.imageView.image = photo;
        } else {
            
            [[PHImageManager defaultManager] cancelImageRequest:self.qh_imageRequestID];
        }
        
        if (!isDegraded) {
            
            self.qh_imageRequestID = 0;
        }
    }];
    
    if (imageRequestID && self.qh_imageRequestID && imageRequestID != self.qh_imageRequestID) {
        
        [[PHImageManager defaultManager] cancelImageRequest:self.qh_imageRequestID];
    }
    
    self.qh_imageRequestID = imageRequestID;
    self.qh_selectButton.selected = qh_assetModel.qh_isSelected;
    self.selectedImageView.image = self.qh_selectButton.isSelected ? [UIImage imageNamed:@"selected"] : [UIImage imageNamed:@"unselected"];
    self.qh_cellType = (NSUInteger)qh_assetModel.qh_asset;
    
    // 让宽度/高度小于 最小可选照片尺寸 的图片不能选中
    if (![[GQHImageManager qh_manager] qh_checkSelectableStatusWithAsset:qh_assetModel.qh_asset]) {
        
        if (_selectedImageView.hidden == NO) {
            
            self.qh_selectButton.hidden = YES;
            _selectedImageView.hidden = YES;
        }
    }
    
    // 如果用户选中了该图片，提前获取一下大图
    if (qh_assetModel.qh_isSelected) {
        
        [self fetchOriginalPhoto];
    }
    
    [self setNeedsLayout];
}

// 获取原图
- (void)fetchOriginalPhoto {
    
    _originalImageRequestID = [[GQHImageManager qh_manager] qh_fetchPhotoWithAsset:_qh_assetModel.qh_asset networkAccessAllowed:YES progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        
        if (_qh_assetModel.qh_asset) {
            
            progress = progress > 0.02 ? progress : 0.02;
            self.progressView.qh_progress = progress;
            self.progressView.hidden = NO;
            self.imageView.alpha = 0.4;
            
            if (progress >= 1) {
                
                [self hideProgressView];
            }
        } else {
            
            *stop = YES;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    } completionHandler:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        
        if (_progressView) {
            
            [self hideProgressView];
        }
    }];
}

- (void)hideProgressView {
    
    self.progressView.hidden = YES;
    self.imageView.alpha = 1.0;
}

- (void)setQh_showSelectButton:(BOOL)qh_showSelectButton {
    
    _qh_showSelectButton = qh_showSelectButton;
    if (!self.qh_selectButton.hidden) {
        
        self.qh_selectButton.hidden = !qh_showSelectButton;
    }
    if (!self.selectedImageView.hidden) {
        
        self.selectedImageView.hidden = !qh_showSelectButton;
    }
    
}

- (void)setQh_cellType:(GQHAssetCellType)qh_cellType {
    
    _qh_cellType = qh_cellType;
    if (qh_cellType == GQHAssetCellTypePhoto || qh_cellType == GQHAssetCellTypeLivePhoto || (qh_cellType == GQHAssetCellTypeGIFPhoto && !self.qh_canPickGIF) || self.qh_canPickMultipleVideo) {
        
        _selectedImageView.hidden = NO;
        _qh_selectButton.hidden = NO;
        _bottomView.hidden = YES;
    } else {
        
        _selectedImageView.hidden = YES;
        _qh_selectButton.hidden = YES;
    }
    if (qh_cellType == GQHAssetCellTypeVideo) {
        
        self.bottomView.hidden = NO;
        self.timeLabel.text = _qh_assetModel.qh_duration;
        self.videoImageView.hidden = NO;
        
        _timeLabel.textAlignment = NSTextAlignmentRight;
        CGFloat x = CGRectGetMaxX(self.videoImageView.frame) - _timeLabel.frame.size.width;
        _timeLabel.frame = CGRectMake(x, _timeLabel.frame.origin.y, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    } else if (qh_cellType == GQHAssetCellTypeGIFPhoto && self.qh_canPickGIF) {
        
        self.bottomView.hidden = NO;
        self.timeLabel.text = @"GIF";
        self.videoImageView.hidden = YES;
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.frame = CGRectMake(CGRectGetMaxX(self.videoImageView.frame), _timeLabel.frame.origin.y, _timeLabel.frame.size.width, _timeLabel.frame.size.height);
    }
}

- (IBAction)clickSelectButton:(UIButton *)sender {
    
    if (self.didSelectPhotoBlock) {
        
        self.didSelectPhotoBlock(sender.isSelected);
    }
    self.selectedImageView.image = sender.isSelected ? [UIImage imageNamed:@"selected"] : [UIImage imageNamed:@"unselected"];
    if (sender.isSelected) {
        
        [UIView qh_animateScaledWithLayer:_selectedImageView.layer type:GQHAnimationScaledTypeDownUp];
        [self fetchOriginalPhoto];
    } else {
        
        if (_originalImageRequestID && _progressView) {
            
            [[PHImageManager defaultManager] cancelImageRequest:_originalImageRequestID];
            [self hideProgressView];
        }
    }
}

#pragma mark --Lazyload(Getter)
- (UIButton *)qh_selectButton {
    
    if (!_qh_selectButton) {
        
        _qh_selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qh_selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_qh_selectButton];
    }
    
    return _qh_selectButton;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        [self.contentView bringSubviewToFront:_selectedImageView];
        [self.contentView bringSubviewToFront:_bottomView];
    }
    
    return _imageView;
}

- (UIImageView *)selectedImageView {
    
    if (!_selectedImageView) {
        
        _selectedImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_selectedImageView];
    }
    
    return _selectedImageView;
}

- (UIView *)bottomView {
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8f];
        [self.contentView addSubview:_bottomView];
    }
    
    return _bottomView;
}

- (UIImageView *)videoImageView {
    
    if (!_videoImageView) {
        
        _videoImageView = [[UIImageView alloc] init];
        [_videoImageView setImage:[UIImage imageNamed:@""]];
        [self.bottomView addSubview:_videoImageView];
    }
    
    return _videoImageView;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont boldSystemFontOfSize:11];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self.bottomView addSubview:_timeLabel];
    }
    
    return _timeLabel;
}

- (GQHProgressView *)progressView {
    
    if (!_progressView) {
        
        _progressView = [[GQHProgressView alloc] init];
        _progressView.hidden = YES;
        [self addSubview:_progressView];
    }
    
    return _progressView;
}

@end



@implementation TZAssetCell

- (void)setModel:(TZAssetModel *)model {
    _model = model;
    if (iOS8Later) {
        self.representedAssetIdentifier = [[TZImageManager manager] getAssetIdentifier:model.asset];
    }
    int32_t imageRequestID = [[TZImageManager manager] getPhotoWithAsset:model.asset photoWidth:self.tz_width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        if (_progressView) {
            self.progressView.hidden = YES;
            self.imageView.alpha = 1.0;
        }
        // Set the cell's thumbnail image if it's still showing the same asset.
        if (!iOS8Later) {
            self.imageView.image = photo; return;
        }
        if ([self.representedAssetIdentifier isEqualToString:[[TZImageManager manager] getAssetIdentifier:model.asset]]) {
            self.imageView.image = photo;
        } else {
            // NSLog(@"this cell is showing other asset");
            [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        }
        if (!isDegraded) {
            self.imageRequestID = 0;
        }
    } progressHandler:nil networkAccessAllowed:NO];
    if (imageRequestID && self.imageRequestID && imageRequestID != self.imageRequestID) {
        [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        // NSLog(@"cancelImageRequest %d",self.imageRequestID);
    }
    self.imageRequestID = imageRequestID;
    self.selectPhotoButton.selected = model.isSelected;
    self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamedFromMyBundle:self.photoSelImageName] : [UIImage imageNamedFromMyBundle:self.photoDefImageName];
    self.type = (NSInteger)model.type;
    // 让宽度/高度小于 最小可选照片尺寸 的图片不能选中
    if (![[TZImageManager manager] isPhotoSelectableWithAsset:model.asset]) {
        if (_selectImageView.hidden == NO) {
            self.selectPhotoButton.hidden = YES;
            _selectImageView.hidden = YES;
        }
    }
    // 如果用户选中了该图片，提前获取一下大图
    if (model.isSelected) {
        [self fetchBigImage];
    }
    [self setNeedsLayout];
}

- (void)setShowSelectBtn:(BOOL)showSelectBtn {
    _showSelectBtn = showSelectBtn;
    if (!self.selectPhotoButton.hidden) {
        self.selectPhotoButton.hidden = !showSelectBtn;
    }
    if (!self.selectImageView.hidden) {
        self.selectImageView.hidden = !showSelectBtn;
    }
}

- (void)setType:(TZAssetCellType)type {
    _type = type;
    if (type == TZAssetCellTypePhoto || type == TZAssetCellTypeLivePhoto || (type == TZAssetCellTypePhotoGif && !self.allowPickingGif) || self.allowPickingMultipleVideo) {
        _selectImageView.hidden = NO;
        _selectPhotoButton.hidden = NO;
        _bottomView.hidden = YES;
    } else { // Video of Gif
        _selectImageView.hidden = YES;
        _selectPhotoButton.hidden = YES;
    }
    
    if (type == TZAssetCellTypeVideo) {
        self.bottomView.hidden = NO;
        self.timeLength.text = _model.timeLength;
        self.videoImgView.hidden = NO;
        _timeLength.tz_left = self.videoImgView.tz_right;
        _timeLength.textAlignment = NSTextAlignmentRight;
    } else if (type == TZAssetCellTypePhotoGif && self.allowPickingGif) {
        self.bottomView.hidden = NO;
        self.timeLength.text = @"GIF";
        self.videoImgView.hidden = YES;
        _timeLength.tz_left = 5;
        _timeLength.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)selectPhotoButtonClick:(UIButton *)sender {
    if (self.didSelectPhotoBlock) {
        self.didSelectPhotoBlock(sender.isSelected);
    }
    self.selectImageView.image = sender.isSelected ? [UIImage imageNamedFromMyBundle:self.photoSelImageName] : [UIImage imageNamedFromMyBundle:self.photoDefImageName];
    if (sender.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:_selectImageView.layer type:TZOscillatoryAnimationToBigger];
        // 用户选中了该图片，提前获取一下大图
        [self fetchBigImage];
    } else { // 取消选中，取消大图的获取
        if (_bigImageRequestID && _progressView) {
            [[PHImageManager defaultManager] cancelImageRequest:_bigImageRequestID];
            [self hideProgressView];
        }
    }
}

- (void)hideProgressView {
    self.progressView.hidden = YES;
    self.imageView.alpha = 1.0;
}

- (void)fetchBigImage {
    _bigImageRequestID = [[TZImageManager manager] getPhotoWithAsset:_model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        if (_progressView) {
            [self hideProgressView];
        }
    } progressHandler:^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
        if (_model.isSelected) {
            progress = progress > 0.02 ? progress : 0.02;;
            self.progressView.progress = progress;
            self.progressView.hidden = NO;
            self.imageView.alpha = 0.4;
            if (progress >= 1) {
                [self hideProgressView];
            }
        } else {
            *stop = YES;
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    } networkAccessAllowed:YES];
}

@end
