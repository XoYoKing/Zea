//
//  GQHAboutController.m
//  Seed
//
//  Created by GuanQinghao on 09/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#pragma mark Macro
#import "GQHHeader.h"

#pragma mark Model

#pragma mark Object

#pragma mark View
#import "GQHAboutView.h"

#pragma mark Controller
#import "GQHAboutController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------

@interface GQHAboutController ()

/// 自定义根视图
@property (nonatomic, strong) GQHAboutView *rootView;

@end


@implementation GQHAboutController

#pragma mark --Lifecycle
- (void)loadView {
    // 添加自定义视图
    DLog();
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
    
    // 应用图标
    self.rootView.qh_appImageView.image = [UIImage imageNamed:@"icon"];
    
    // 应用名称
    NSString *nameString = [NSString stringWithFormat:@"%@",UIApplication.sharedApplication.qh_applicationDisplayName];
    self.rootView.qh_appNameLabel.text = nameString;
    
    // 应用版本
    NSString *versionString = [NSString stringWithFormat:@"v %@",UIApplication.sharedApplication.qh_applicationShortVersion];
    self.rootView.qh_appVersionLabel.text = versionString;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog();
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"about", @"关于") forState:UIControlStateNormal];
    
    self.qh_rightMostButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog();
    
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (GQHAboutView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHAboutView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    
    return _rootView;
}

@end
