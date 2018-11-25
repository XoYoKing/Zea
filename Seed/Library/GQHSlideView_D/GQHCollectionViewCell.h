//
//  GQHCollectionViewCell.h
//  Seed
//
//  Created by GuanQinghao on 12/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQHCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *qh_title;
@property (nonatomic, strong) UIImageView *qh_imageView;

@property (nonatomic, strong) UIColor *qh_titleLabelBackgroundColor;
@property (nonatomic, strong) UIColor *qh_titleLabelTextColor;
@property (nonatomic, strong) UIFont *qh_titleLabelTextFont;

@property (nonatomic, assign) CGFloat qh_titleLabelHeight;
@property (nonatomic, assign) NSTextAlignment qh_titleLabelTextAlignment;

@property (nonatomic, assign) BOOL qh_hasConfigured;
@property (nonatomic, assign) BOOL qh_onlyText;

@end
