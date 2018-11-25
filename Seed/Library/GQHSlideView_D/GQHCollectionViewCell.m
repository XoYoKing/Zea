//
//  GQHCollectionViewCell.m
//  Seed
//
//  Created by GuanQinghao on 12/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHCollectionViewCell.h"


@interface GQHCollectionViewCell () {
    
    UILabel *titleLabel;
}

@end


@implementation GQHCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupImageView];
        [self setupTitleLabel];
    }
    return self;
}

- (void)setupImageView {
    
    _qh_imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_qh_imageView];
}

- (void)setupTitleLabel {
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.qh_onlyText) {
        
        titleLabel.frame = self.bounds;
    } else {
        
        _qh_imageView.frame = self.bounds;
        
        CGFloat titleLabelWidth = CGRectGetWidth(self.frame);
        CGFloat titleLabelHeight = _qh_titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = CGRectGetHeight(self.frame) - _qh_titleLabelHeight;
        
        titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    }
}

- (void)setQh_title:(NSString *)qh_title {
    
    _qh_title = qh_title;
    titleLabel.text = [NSString stringWithFormat:@"%@",qh_title];
    if (titleLabel.hidden) {
        
        titleLabel.hidden = NO;
    }
}

- (void)setQh_titleLabelBackgroundColor:(UIColor *)qh_titleLabelBackgroundColor {
    
    _qh_titleLabelBackgroundColor = qh_titleLabelBackgroundColor;
    titleLabel.backgroundColor = qh_titleLabelBackgroundColor;
}

- (void)setQh_titleLabelTextColor:(UIColor *)qh_titleLabelTextColor {
    
    _qh_titleLabelTextColor = qh_titleLabelTextColor;
    titleLabel.textColor = qh_titleLabelTextColor;
}

- (void)setQh_titleLabelTextFont:(UIFont *)qh_titleLabelTextFont {
    
    _qh_titleLabelTextFont = qh_titleLabelTextFont;
    titleLabel.font = qh_titleLabelTextFont;
}

- (void)setQh_titleLabelTextAlignment:(NSTextAlignment)qh_titleLabelTextAlignment {
    
    _qh_titleLabelTextAlignment = qh_titleLabelTextAlignment;
    titleLabel.textAlignment = qh_titleLabelTextAlignment;
}

@end
