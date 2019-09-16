//
//  GQHBaseViewController+GQHNavigationBar.m
//  Seed
//
//  Created by Mac on 2019/5/27.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseViewController+GQHNavigationBar.h"
#import "GQHHeader.h"
#import <objc/message.h>


@implementation GQHBaseViewController (GQHNavigationBar)

#pragma mark - TargetMethod
/**
 点击导航栏返回按钮
 
 @param sender 导航栏返回按钮
 */
- (IBAction)qh_didClickBackButton:(UIButton *)sender {
    NSLog(@"");
    
    if (self.navigationController) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 点击导航栏左按钮
 
 @param sender 导航栏左按钮
 */
- (IBAction)qh_didClickLeftButton:(UIButton *)sender {
    NSLog(@"");
    
}

/**
 点击导航栏标题栏
 
 @param sender 导航栏标题栏
 */
- (IBAction)qh_didClickTitleButton:(UIButton *)sender {
    NSLog(@"");
    
}

/**
 点击导航栏右按钮
 
 @param sender 导航栏右按钮
 */
- (IBAction)qh_didClickRightButton:(UIButton *)sender {
    NSLog(@"");
    
}

/**
 点击导航栏最右按钮
 
 @param sender 导航栏最右按钮
 */
- (IBAction)qh_didClickRightMostButton:(UIButton *)sender {
    NSLog(@"");
    
}

#pragma mark - PrivateMethod

/**
 添加导航栏
 */
- (void)qh_addNavigationBar {
    NSLog(@"");
    
    // 自定义导航栏
    [self.view addSubview:self.qh_navigationBar];
    
    // 自定义导航栏分割线
    [self.qh_navigationBar addSubview:self.qh_navigationBarLine];
    
    // 自定义导航栏返回按钮
    [self.qh_navigationBar addSubview:self.qh_backButton];
   
    // 自定义导航栏左按钮
    [self.qh_navigationBar addSubview:self.qh_leftButton];
    
    // 自定义导航栏最右按钮
    [self.qh_navigationBar addSubview:self.qh_rightMostButton];
    
    // 自定义导航栏右按钮
    [self.qh_navigationBar addSubview:self.qh_rightButton];
    
    // 自定义导航栏标题栏
    [self.qh_navigationBar addSubview:self.qh_titleButton];
}

/**
 布局自定义导航栏视图
 */
- (void)qh_layoutNavigationBar {
    NSLog(@"");
    
    // 导航栏安全边距
    CGFloat safeAreaLeft = 0.0f;
    CGFloat safeAreaRight = 0.0f;
    
    if (@available(iOS 11.0, *)) {
        
        safeAreaLeft = UIApplication.sharedApplication.delegate.window.safeAreaInsets.left;
        safeAreaRight = UIApplication.sharedApplication.delegate.window.safeAreaInsets.right;
    }
    
    // 自定义导航栏
    [self.qh_navigationBar mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.and.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view.qh_statusBarHeight + self.view.qh_navigationBarHeight);
    }];
    
    // 自定义导航栏标题栏
    [self.qh_navigationBarLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.bottom.and.right.mas_equalTo(self.qh_navigationBar);
        make.height.mas_equalTo(1.0f);
    }];

    // 自定义导航栏返回按钮
    [self.qh_backButton mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.qh_navigationBar).with.inset(self.view.qh_statusBarHeight);
        make.left.mas_equalTo(self.qh_navigationBar).with.inset(safeAreaLeft);
        make.size.mas_equalTo(CGSizeMake(self.view.qh_navigationBarHeight, self.view.qh_navigationBarHeight));
    }];

    // 自定义导航栏左按钮
    [self.qh_leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.qh_backButton);
        make.left.mas_equalTo(self.qh_backButton.mas_right);
        make.width.mas_greaterThanOrEqualTo(self.view.qh_navigationBarHeight);
        make.height.mas_equalTo(self.view.qh_navigationBarHeight);
    }];

    // 自定义导航栏最右按钮
    [self.qh_rightMostButton mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.qh_backButton);
        make.right.mas_equalTo(self.qh_navigationBar).with.inset(safeAreaRight);
        make.width.mas_greaterThanOrEqualTo(self.view.qh_navigationBarHeight);
        make.height.mas_equalTo(self.view.qh_navigationBarHeight);
    }];

    // 自定义导航栏右按钮
    [self.qh_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.qh_backButton);
        make.right.mas_equalTo(self.qh_rightMostButton.mas_left);
        make.width.mas_greaterThanOrEqualTo(self.view.qh_navigationBarHeight);
        make.height.mas_equalTo(self.view.qh_navigationBarHeight);
    }];

    // 自定义导航栏标题栏
    [self.qh_titleButton mas_remakeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.qh_backButton);
        make.bottom.mas_equalTo(self.qh_navigationBar);
        make.centerX.mas_equalTo(self.qh_navigationBar);
    }];
    
    // 分割线放到最前面
    [self.qh_navigationBar bringSubviewToFront:self.qh_navigationBarLine];
}

#pragma mark - Setter/Getter

/**
 导航栏
 */
- (void)setQh_navigationBar:(UIView *)qh_navigationBar {
    
    objc_setAssociatedObject(self, @selector(qh_navigationBar), qh_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)qh_navigationBar {
    
    UIView *navigationBar = objc_getAssociatedObject(self, _cmd);

    if (!navigationBar) {

        navigationBar = [[UIView alloc] init];
        navigationBar.backgroundColor = [UIColor whiteColor];
        
        self.qh_navigationBar = navigationBar;
    }

    return navigationBar;
}

/**
 导航栏分割线
 */
- (void)setQh_navigationBarLine:(UIView *)qh_navigationBarLine {
    
    objc_setAssociatedObject(self, @selector(qh_navigationBarLine), qh_navigationBarLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)qh_navigationBarLine {
    
    UIView *line = objc_getAssociatedObject(self, _cmd);
    
    if (!line) {
        
        line = [[UIView alloc] init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.qh_navigationBarLine = line;
    }
    
    return line;
}

/**
 返回按钮
 */
- (void)setQh_backButton:(UIButton *)qh_backButton {
    
    objc_setAssociatedObject(self, @selector(qh_backButton), qh_backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)qh_backButton {
    
    UIButton *backButton = objc_getAssociatedObject(self, _cmd);
    
    if (!backButton) {
        
        backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.backgroundColor = [UIColor clearColor];
        backButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        backButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [backButton setTitleColor:[UIColor qh_colorWithHexString:GQHFontColorLightBlack] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:GQHNavigationBarLeftArrowBlack] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(qh_didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.qh_backButton = backButton;
    }
    
    return backButton;
}

/**
 左按钮
 */
- (void)setQh_leftButton:(UIButton *)qh_leftButton {
    
    objc_setAssociatedObject(self, @selector(qh_leftButton), qh_leftButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)qh_leftButton {
    
    UIButton *leftButton = objc_getAssociatedObject(self, _cmd);
    
    if (!leftButton) {
        
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.backgroundColor = [UIColor clearColor];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [leftButton setTitleColor:[UIColor qh_colorWithHexString:GQHFontColorLightBlack] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(qh_didClickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.qh_leftButton = leftButton;
    }
    
    return leftButton;
}

/**
 标题按钮
 */
- (void)setQh_titleButton:(UIButton *)qh_titleButton {
    
    objc_setAssociatedObject(self, @selector(qh_titleButton), qh_titleButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)qh_titleButton {
    
    UIButton *titleButton = objc_getAssociatedObject(self, _cmd);
    
    if (!titleButton) {
        
        titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.backgroundColor = [UIColor clearColor];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleButton setTitleColor:[UIColor qh_colorWithHexString:GQHFontColorLightBlack] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(qh_didClickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.qh_titleButton = titleButton;
    }
    
    return titleButton;
}

/**
 右按钮
 */
- (void)setQh_rightButton:(UIButton *)qh_rightButton {
    
    objc_setAssociatedObject(self, @selector(qh_rightButton), qh_rightButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)qh_rightButton {
    
    UIButton *rightButton = objc_getAssociatedObject(self, _cmd);
    
    if (!rightButton) {
        
        rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.backgroundColor = [UIColor clearColor];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [rightButton setTitleColor:[UIColor qh_colorWithHexString:GQHFontColorLightBlack] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(qh_didClickRightButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.qh_rightButton = rightButton;
    }
    
    return rightButton;
}

/**
 最右按钮
 */
- (void)setQh_rightMostButton:(UIButton *)qh_rightMostButton {
    
    objc_setAssociatedObject(self, @selector(qh_rightMostButton), qh_rightMostButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)qh_rightMostButton {
    
    UIButton *rightMostButton = objc_getAssociatedObject(self, _cmd);
    
    if (!rightMostButton) {
        
        rightMostButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightMostButton.backgroundColor = [UIColor clearColor];
        rightMostButton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        rightMostButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [rightMostButton setTitleColor:[UIColor qh_colorWithHexString:GQHFontColorLightBlack] forState:UIControlStateNormal];
        [rightMostButton addTarget:self action:@selector(qh_didClickRightMostButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.qh_rightMostButton = rightMostButton;
    }
    
    return rightMostButton;
}

@end
