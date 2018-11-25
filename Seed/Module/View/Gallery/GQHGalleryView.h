//
//  GQHGalleryView.h
//  Seed
//
//  Created by GuanQinghao on 08/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GQHGalleryViewDelegate <NSObject>

@required

@optional

@end


@interface GQHGalleryView : UIView

/// 代理
@property (nonatomic, weak) id<GQHGalleryViewDelegate> qh_delegate;
/// 图库图片集合视图
@property (nonatomic, strong) UICollectionView *qh_imageCollectionView;

@end


/// 图库Cell
@interface GQHGalleryViewCell : UICollectionViewCell

/// 图库图片视图
@property (nonatomic, strong) UIImageView *qh_imageView;
///
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
