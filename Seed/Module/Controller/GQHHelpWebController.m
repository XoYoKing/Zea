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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
