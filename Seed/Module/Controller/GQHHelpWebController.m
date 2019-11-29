//
//  GQHHelpWebController.m
//  Seed
//
//  Created by Mac on 2019/11/21.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHHelpWebController.h"
#import "GQHBaseViewController+GQHNavigationBar.h"


@interface GQHHelpWebController ()

@end

@implementation GQHHelpWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"help", @"帮助") forState:UIControlStateNormal];
}

@end
