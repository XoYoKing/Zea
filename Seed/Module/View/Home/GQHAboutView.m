//
//  GQHAboutView.m
//  Seed
//
//  Created by GuanQinghao on 09/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHAboutView.h"
#import "GQHHeader.h"


@interface GQHAboutView ()

/// 应用程序版权信息
@property (nonatomic, strong) UILabel *appCopyrightLabel;

@end


@implementation GQHAboutView

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
    
    [self addSubview:self.qh_appImageView];
    [self.qh_appImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight + self.qh_navigationBarHeight + 50.0f);
        make.size.mas_equalTo(CGSizeMake(90.0f, 90.0f));
    }];
    
    [self addSubview:self.qh_appNameLabel];
    [self.qh_appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_appImageView.mas_bottom);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(50.0f);
    }];
    
    [self addSubview:self.qh_appDescriptionLabel];
    [self.qh_appDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_appNameLabel.mas_bottom);
        make.left.and.right.mas_equalTo(self).with.inset(GQHFrameSingleMargin);
        make.height.mas_equalTo(100.0f);
    }];
    
    [self addSubview:self.appCopyrightLabel];
    [self.appCopyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self).with.inset(self.qh_homeIndicatorHeight);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(60.0f);
    }];
    
    [self addSubview:self.qh_appVersionLabel];
    [self.qh_appVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.appCopyrightLabel.mas_top);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(40.0f);
    }];
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (UIImageView *)qh_appImageView {
    
    if (!_qh_appImageView) {
        
        _qh_appImageView = [[UIImageView alloc] init];
        _qh_appImageView.layer.cornerRadius = 5.0f;
        _qh_appImageView.layer.masksToBounds = YES;
    }
    
    return _qh_appImageView;
}

- (UILabel *)qh_appNameLabel {
    
    if (!_qh_appNameLabel) {
        
        _qh_appNameLabel = [[UILabel alloc] init];
        _qh_appNameLabel.textColor = UIColor.blackColor;
        _qh_appNameLabel.textAlignment = NSTextAlignmentCenter;
        _qh_appNameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    }
    
    return _qh_appNameLabel;
}

- (UILabel *)qh_appDescriptionLabel {
    
    if (!_qh_appDescriptionLabel) {
        
        _qh_appDescriptionLabel = [[UILabel alloc] init];
        _qh_appDescriptionLabel.textColor = UIColor.blackColor;
        _qh_appDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _qh_appDescriptionLabel;
}

- (UILabel *)qh_appVersionLabel {
    
    if (!_qh_appVersionLabel) {
        
        _qh_appVersionLabel = [[UILabel alloc] init];
        _qh_appVersionLabel.textColor = UIColor.darkGrayColor;
        _qh_appVersionLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _qh_appVersionLabel;
}

- (UILabel *)appCopyrightLabel {
    
    if (!_appCopyrightLabel) {
        
        _appCopyrightLabel = [[UILabel alloc] init];
        _appCopyrightLabel.text = @"Copyright © 2018 Guan Qinghao. All rights reserved.";
        _appCopyrightLabel.textColor = UIColor.darkGrayColor;
        _appCopyrightLabel.textAlignment = NSTextAlignmentCenter;
        _appCopyrightLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    
    return _appCopyrightLabel;
}

@end
