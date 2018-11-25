//
//  GQHBaseController.m
//  Seed
//
//  Created by GuanQinghao on 24/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHBaseController.h"
#import "GQHHeader.h"


@interface GQHBaseController () <UIGestureRecognizerDelegate>

@end

@implementation GQHBaseController

#pragma mark --Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog();
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog();
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    DLog();
    
}

#pragma mark --Data

#pragma mark --Delegate

#pragma mark --TargetMethod
/// 导航栏返回按钮点击动作
- (IBAction)qh_clickedBackButton:(UIButton *)sender {
    DLog();
    if (self.navigationController) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/// 导航栏左按钮点击动作
- (IBAction)qh_clickedLeftButton:(UIButton *)sender {
    DLog();
}
/// 导航栏标题栏点击动作
- (IBAction)qh_clickedTitleButton:(UIButton *)sender {
    DLog();
}
/// 导航栏右按钮点击动作
- (IBAction)qh_clickedRightButton:(UIButton *)sender {
    DLog();
}
/// 导航栏最右按钮点击动作
- (IBAction)qh_clickedRightMostButton:(UIButton *)sender {
    DLog();
}

#pragma mark --PrivateMethod
- (void)loadNavigationBar {
    
    
    /// 自定义导航条
    [self.view addSubview:self.qh_navigationBar];
    [self.qh_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.qh_statusBarHeight + self.view.qh_navigationBarHeight);
    }];
    
    /// 自定义导航返回按钮
    [self.qh_navigationBar addSubview:self.qh_backButton];
    [self.qh_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_navigationBar).with.inset(self.view.qh_statusBarHeight);
        make.left.mas_equalTo(self.qh_navigationBar);
        make.size.mas_equalTo(CGSizeMake(self.view.qh_navigationBarHeight, self.view.qh_navigationBarHeight));
    }];
    
    /// 自定义导航左按钮
    [self.qh_navigationBar addSubview:self.qh_leftButton];
    [self.qh_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_backButton);
        make.left.mas_equalTo(self.qh_backButton.mas_right);
        make.size.mas_equalTo(CGSizeMake(self.view.qh_navigationBarHeight, self.view.qh_navigationBarHeight));
    }];
    
    /// 自定义导航最右按钮
    [self.qh_navigationBar addSubview:self.qh_rightMostButton];
    [self.qh_rightMostButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_backButton);
        make.right.mas_equalTo(self.qh_navigationBar);
        make.size.mas_equalTo(CGSizeMake(self.view.qh_navigationBarHeight, self.view.qh_navigationBarHeight));
    }];
    
    /// 自定义导航右按钮
    [self.qh_navigationBar addSubview:self.qh_rightButton];
    [self.qh_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_backButton);
        make.right.mas_equalTo(self.qh_rightMostButton.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.qh_navigationBarHeight, self.view.qh_navigationBarHeight));
    }];
    
    /// 自定义导航标题栏
    [self.qh_navigationBar addSubview:self.qh_titleButton];
    [self.qh_titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_backButton);
        make.left.mas_equalTo(self.qh_leftButton.mas_right);
        make.bottom.mas_equalTo(self.qh_navigationBar);
        make.right.mas_equalTo(self.qh_rightButton.mas_left);
    }];
}

#pragma mark --Setter

#pragma mark --Getter
/// 自定义导航条
- (UIView *)qh_navigationBar {
    
    if (!_qh_navigationBar) {
        
        _qh_navigationBar = [[UIView alloc] init];
        _qh_navigationBar.backgroundColor = UIColor.qh_appRedColor;
    }
    
    return _qh_navigationBar;
}
/// 自定义导航返回按钮
- (UIButton *)qh_backButton {
    
    if (!_qh_backButton) {
        
        _qh_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qh_backButton.titleLabel.font = UIFont.qh_defaultFont;
        _qh_backButton.titleLabel.textColor = UIColor.whiteColor;
        _qh_backButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_qh_backButton setBackgroundImage:[UIImage imageNamed:@"basic_navigationbar_left_arrow"] forState:UIControlStateNormal];
        [_qh_backButton addTarget:self action:@selector(qh_clickedBackButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _qh_backButton;
}
/// 自定义导航左按钮
- (UIButton *)qh_leftButton {
    
    if (!_qh_leftButton) {
        
        _qh_leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qh_leftButton.hidden = YES;
        _qh_leftButton.titleLabel.font = UIFont.qh_defaultFont;
        _qh_leftButton.titleLabel.textColor = UIColor.whiteColor;
        _qh_leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_qh_leftButton addTarget:self action:@selector(qh_clickedLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _qh_leftButton;
}
/// 自定义导航标题栏
- (UIButton *)qh_titleButton {
    
    if (!_qh_titleButton) {
        
        _qh_titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qh_titleButton.userInteractionEnabled = NO;
        _qh_titleButton.titleLabel.font = UIFont.qh_defaultFont;
        _qh_titleButton.titleLabel.textColor = UIColor.whiteColor;
        _qh_titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_qh_titleButton addTarget:self action:@selector(qh_clickedTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _qh_titleButton;
}
/// 自定义导航右按钮
- (UIButton *)qh_rightButton {
    
    if (!_qh_rightButton) {
        
        _qh_rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qh_rightButton.hidden = YES;
        _qh_rightButton.titleLabel.font = UIFont.qh_defaultFont;
        _qh_rightButton.titleLabel.textColor = UIColor.whiteColor;
        _qh_rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_qh_rightButton addTarget:self action:@selector(qh_clickedRightButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _qh_rightButton;
}
/// 自定义导航最右按钮
- (UIButton *)qh_rightMostButton {
    
    if (!_qh_rightMostButton) {
        
        _qh_rightMostButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _qh_rightMostButton.titleLabel.font = UIFont.qh_defaultFont;
        _qh_rightMostButton.titleLabel.textColor = UIColor.whiteColor;
        _qh_rightMostButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_qh_rightMostButton addTarget:self action:@selector(qh_clickedRightMostButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _qh_rightMostButton;
}

@end
