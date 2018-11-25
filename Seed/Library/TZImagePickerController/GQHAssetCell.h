//
//  GQHAssetCell.h
//  GQHKit
//
//  Created by GuanQinghao on 07/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GQHAssetCellTypePhoto,      // 照片
    GQHAssetCellTypeLivePhoto,  // 现场照片
    GQHAssetCellTypeGIFPhoto,   // 动态图
    GQHAssetCellTypeVideo,      // 视频
    GQHAssetCellTypeAudio       // 音频
} GQHAssetCellType;

@class GQHAssetModel;
@interface GQHAssetCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *qh_selectButton;
@property (nonatomic, strong) GQHAssetModel *qh_assetModel;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) GQHAssetCellType qh_cellType;
@property (nonatomic, assign) BOOL qh_canPickGIF;
@property (nonatomic, assign) BOOL qh_canPickMultipleVideo;
@property (nonatomic, copy) NSString *qh_representedAssetIdentifier;
@property (nonatomic, assign) int32_t qh_imageRequestID;


@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;


@property (nonatomic, assign) BOOL qh_showSelectButton;
@property (nonatomic, assign) BOOL qh_canPreview;

@end
