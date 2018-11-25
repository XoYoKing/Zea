//
//  GQHRecordController.m
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
#import "GQHRecordView.h"

#pragma mark Controller
#import "GQHRecordController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------


@interface GQHRecordController ()

/// 自定义根视图
@property (nonatomic, strong) GQHRecordView *rootView;

@end


@implementation GQHRecordController

#pragma mark --Lifecycle
- (void)loadView {
    /// 添加自定义视图
    DLog();
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog();
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"record", @"游戏记录") forState:UIControlStateNormal];
    
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
- (GQHRecordView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHRecordView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    }
    
    return _rootView;
}

@end
