//
//  GQHBaseViewController+GQHNavigationBar.h
//  Seed
//
//  Created by Mac on 2019/5/27.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface GQHBaseViewController (GQHNavigationBar)

/**
 自定义导航栏视图
 */
@property (nonatomic, strong) UIView *qh_navigationBar;

/**
 自定义导航栏分割线
 */
@property (nonatomic, strong) UIView *qh_navigationBarLine;

/**
 自定义导航栏返回按钮
 */
@property (nonatomic, strong) UIButton *qh_backButton;

/**
 自定义导航栏左按钮
 */
@property (nonatomic, strong) UIButton *qh_leftButton;

/**
 自定义导航栏标题按钮
 */
@property (nonatomic, strong) UIButton *qh_titleButton;

/**
 自定义导航栏右按钮
 */
@property (nonatomic, strong) UIButton *qh_rightButton;

/**
 自定义导航栏最右按钮
 */
@property (nonatomic, strong) UIButton *qh_rightMostButton;


/**
 添加导航栏
 */
- (void)qh_addNavigationBar;

/**
 布局自定义导航栏视图
 */
- (void)qh_layoutNavigationBar;


/**
 点击导航栏返回按钮
 
 @param sender 导航栏返回按钮
 */
- (IBAction)qh_didClickBackButton:(UIButton *)sender;

/**
 点击导航栏左按钮
 
 @param sender 导航栏左按钮
 */
- (IBAction)qh_didClickLeftButton:(UIButton *)sender;

/**
 点击导航栏标题栏
 
 @param sender 导航栏标题栏
 */
- (IBAction)qh_didClickTitleButton:(UIButton *)sender;

/**
 点击导航栏右按钮
 
 @param sender 导航栏右按钮
 */
- (IBAction)qh_didClickRightButton:(UIButton *)sender;

/**
 点击导航栏最右按钮
 
 @param sender 导航栏最右按钮
 */
- (IBAction)qh_didClickRightMostButton:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
