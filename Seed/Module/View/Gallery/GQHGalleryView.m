
//
//  GQHGalleryView.m
//  Seed
//
//  Created by GuanQinghao on 08/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHGalleryView.h"
#import "GQHHeader.h"


@interface GQHGalleryView ()

@end


@implementation GQHGalleryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadLocalData];
        [self loadUserInterface];
    }
    return self;
}

#pragma mark --Data
- (void)loadLocalData {
    
}

#pragma mark --View
- (void)loadUserInterface {
    
    [self addSubview:self.qh_imageCollectionView];
    [self.qh_imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.offset(self.qh_statusBarHeight + self.qh_navigationBarHeight);
        make.left.and.right.and.bottom.mas_equalTo(self);
    }];
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (UICollectionView *)qh_imageCollectionView {
    
    if (!_qh_imageCollectionView) {
        
        _qh_imageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _qh_imageCollectionView.backgroundColor = UIColor.whiteColor;
        _qh_imageCollectionView.showsVerticalScrollIndicator = NO;
        _qh_imageCollectionView.allowsMultipleSelection = NO;
        [_qh_imageCollectionView registerClass:[GQHGalleryViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GQHGalleryViewCell class])];
    }
    
    return _qh_imageCollectionView;
}

@end


@interface GQHGalleryViewCell ()

@end


@implementation GQHGalleryViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadUserInterface];
    }
    
    return self;
}

#pragma mark --View
- (void)loadUserInterface {
    
    [self.contentView addSubview:self.qh_imageView];
    [self.qh_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if (selected) {
        
        self.qh_imageView.layer.borderColor = UIColor.qh_appRedColor.CGColor;
        self.qh_imageView.layer.borderWidth = 2.0f;
    } else {
        
        self.qh_imageView.layer.borderColor = UIColor.clearColor.CGColor;
        self.qh_imageView.layer.borderWidth = CGFLOAT_MIN;
    }
}

#pragma mark --Setter

#pragma mark --Getter
- (UIImageView *)qh_imageView {
    
    if (!_qh_imageView) {
        
        _qh_imageView = [[UIImageView alloc] init];
        _qh_imageView.backgroundColor = UIColor.whiteColor;
        _qh_imageView.layer.cornerRadius = 10.0f;
        _qh_imageView.layer.masksToBounds = YES;
    }
    
    return _qh_imageView;
}

@end
