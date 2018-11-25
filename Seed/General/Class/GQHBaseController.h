//
//  GQHBaseController.h
//  Seed
//
//  Created by GuanQinghao on 24/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GQHBaseController : UIViewController

/// 自定义导航条
@property (nonatomic, strong) UIView *qh_navigationBar;
/// 自定义导航返回按钮
@property (nonatomic, strong) UIButton *qh_backButton;
/// 自定义导航左按钮
@property (nonatomic, strong) UIButton *qh_leftButton;
/// 自定义导航标题栏
@property (nonatomic, strong) UIButton *qh_titleButton;
/// 自定义导航右按钮
@property (nonatomic, strong) UIButton *qh_rightButton;
/// 自定义导航最右按钮
@property (nonatomic, strong) UIButton *qh_rightMostButton;

/// 导航栏返回按钮点击动作
- (IBAction)qh_clickedBackButton:(UIButton *)sender;
/// 导航栏左按钮点击动作
- (IBAction)qh_clickedLeftButton:(UIButton *)sender;
/// 导航栏标题栏点击动作
- (IBAction)qh_clickedTitleButton:(UIButton *)sender;
/// 导航栏右按钮点击动作
- (IBAction)qh_clickedRightButton:(UIButton *)sender;
/// 导航栏最右按钮点击动作
- (IBAction)qh_clickedRightMostButton:(UIButton *)sender;

@end
