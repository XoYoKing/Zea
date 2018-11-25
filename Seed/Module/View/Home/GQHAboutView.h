//
//  GQHAboutView.h
//  Seed
//
//  Created by GuanQinghao on 09/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQHAboutView : UIView

/// 应用程序图标
@property (nonatomic, strong) UIImageView *qh_appImageView;
/// 应用程序名称
@property (nonatomic, strong) UILabel *qh_appNameLabel;
/// 应用程序描述
@property (nonatomic, strong) UILabel *qh_appDescriptionLabel;
/// 应用程序版本号
@property (nonatomic, strong) UILabel *qh_appVersionLabel;

@end
