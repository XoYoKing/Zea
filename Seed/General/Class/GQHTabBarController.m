//
//  GQHTabBarController.m
//  Seed
//
//  Created by GuanQinghao on 30/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#pragma mark Other
#import "GQHHeader.h"

#pragma mark Model

#pragma mark View

#pragma mark Controller
#import "GQHTabBarController.h"
//#import "GQHHomeController.h"
//#import "GQHDepartmentController.h"
//#import "GQHDiscoverController.h"
//#import "GQHCartController.h"
//#import "GQHMeController.h"


#pragma mark -

@interface GQHTabBarController () <UITabBarControllerDelegate>

@end

@implementation GQHTabBarController

#pragma mark --Lifecycle
/**
 1.加载系统根视图或自定义根视图·
 */
- (void)loadView {
    [super loadView];
    NSLog(@"");
    
}

/**
 2.视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    
    // 设置标签栏视图控制器
    [self loadTabBarControllers];
}

/**
 3.视图即将显示
 
 @param animated 是否显示动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"");
    
}

/**
 4.视图即将布局其子视图
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"");
    
}

/**
 5.视图已经布局其子视图
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"");
    
}

/**
 6.视图已经显示
 
 @param animated 是否显示动画效果
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"");
    
}

/**
 7.视图即将消失
 
 @param animated 是否显示动画效果
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"");
    
}

/**
 8.视图已经消失
 
 @param animated 是否显示动画效果
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"");
    
}

/**
 9.视图被销毁
 */
- (void)dealloc {
    NSLog(@"");
    
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 设置标签栏视图控制器
 */
- (void)loadTabBarControllers {
    
    /**
    GQHHomeController *homeController = [[GQHHomeController alloc] init];
    UINavigationController *homeNavController = [[UINavigationController alloc]initWithRootViewController:homeController];
    homeNavController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"home", @"首页") imageNamed:GQHTabBarItemHomeNormal selectedImageNamed:GQHTabBarItemHomeSelected];
    
    GQHDepartmentController *departmentController = [[GQHDepartmentController alloc] init];
    UINavigationController *departmentNavController = [[UINavigationController alloc]initWithRootViewController:departmentController];
    departmentNavController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"department", @"分类") imageNamed:GQHTabBarItemDepartmentNormal selectedImageNamed:GQHTabBarItemDepartmentSelected];
    
    GQHDiscoverController *discoverController = [[GQHDiscoverController alloc] init];
    UINavigationController *discoverNavController = [[UINavigationController alloc]initWithRootViewController:discoverController];
    discoverNavController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"discover", @"发现") imageNamed:GQHTabBarItemDiscoverNormal selectedImageNamed:GQHTabBarItemDiscoverSelected];
    
    GQHCartController *cartController = [[GQHCartController alloc] init];
    UINavigationController *cartNavController = [[UINavigationController alloc]initWithRootViewController:cartController];
    cartNavController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"cart", @"购物车") imageNamed:GQHTabBarItemCartNormal selectedImageNamed:GQHTabBarItemCartSelected];
    
    GQHMeController *meController = [[GQHMeController alloc]init];
    UINavigationController *meNavController = [[UINavigationController alloc]initWithRootViewController:meController];
    meNavController.tabBarItem = [self createTabBarItem:NSLocalizedString(@"me", @"我的") imageNamed:GQHTabBarItemMeNormal selectedImageNamed:GQHTabBarItemMeSelected];
    
    [self setViewControllers:@[homeNavController, departmentNavController, discoverNavController, cartNavController, meNavController]];
    
    [self setSelectedIndex:0];
     */
}


/**
 创建标签栏TabBarItem

 @param title 标签栏TabBarItem的标题
 @param imageName 标签栏TabBarItem的未选中时的图片名称
 @param selectedImageName 标签栏TabBarItem的选中时的图片名称
 @return 标签栏TabBarItem
 */
- (UITabBarItem *)createTabBarItem:(NSString *)title imageNamed:(NSString *)imageName selectedImageNamed:(NSString *)selectedImageName {
    
    // font
    NSDictionary *unselected = @{NSFontAttributeName:[UIFont systemFontOfSize:GQHFontSizeSmallest],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:GQHFontSizeSmallest],NSForegroundColorAttributeName:[UIColor blackColor]};
    // image
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // tabBarItem
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
    [tabBarItem setTitleTextAttributes:unselected forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selected forState:UIControlStateSelected];
    //    [tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];  // top = -bottem  left = -right
    
    return tabBarItem;
}

#pragma mark - Setter

#pragma mark - Getter

@end
