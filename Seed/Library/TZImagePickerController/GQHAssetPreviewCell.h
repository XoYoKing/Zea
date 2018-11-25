//
//  GQHAssetPreviewCell.h
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GQHAssetModel;

// 抽象类
@interface GQHAssetPreviewCell : UICollectionViewCell

@property (nonatomic, strong) GQHAssetModel *qh_assetModel;

@property (nonatomic, copy) void (^singleTapGestureBlock)(void);


// 设置子视图
- (void)qh_configureSubviews;

// 通知
- (void)qh_previewCollectionViewDidScroll;

@end
