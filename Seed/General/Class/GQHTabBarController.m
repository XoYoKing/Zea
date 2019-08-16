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
#import "GQHUserModel.h"

#pragma mark View

#pragma mark Controller
#import "GQHTabBarController.h"
#import "GQHHomeController.h"

#pragma mark -

@interface GQHTabBarController () <UITabBarControllerDelegate>

/**
 点击次数
 */
@property (nonatomic, assign) NSInteger clicks;

/**
 时间戳
 */
@property (nonatomic, assign) CGFloat oldTimeStamp;

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
    NSDictionary *unselected = @{NSFontAttributeName:[UIFont systemFontOfSize:GQHSmallestFont],NSForegroundColorAttributeName:[UIColor blackColor]};
    NSDictionary *selected = @{NSFontAttributeName:[UIFont systemFontOfSize:GQHSmallestFont],NSForegroundColorAttributeName:[UIColor blackColor]};
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
