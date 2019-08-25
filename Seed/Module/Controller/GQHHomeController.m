//
//  GQHHomeController.m
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#pragma mark Other
#import "GQHHeader.h"

#pragma mark Model

#pragma mark View
#import "GQHHomeView.h"

#pragma mark Controller
#import "GQHHomeController.h"
#import "GQHAppAboutController.h"
#import "GQHRecordsController.h"
#import "GQHGameController.h"
#import "GQHLevelsController.h"
#import "GQHGalleryController.h"


#pragma mark -

@interface GQHHomeController () <UITableViewDelegate, UITableViewDataSource, GQHHomeViewDelegate>

/**
 自定义根视图
 */
@property (nonatomic, strong) GQHHomeView *rootView;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation GQHHomeController

#pragma mark - Lifecycle
/**
 1.加载系统根视图或自定义根视图
 */
- (void)loadView {
    [super loadView];
    NSLog(@"");
    
    self.view = self.rootView;
}

/**
 2.视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    
    self.qh_navigationBar.hidden = YES;
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

#pragma mark - UITableViewDataSource
/**
 列表视图的总组数
 
 @param tableView 列表视图
 @return 列表视图的总组数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"");
    
    return 1;
}

/**
 列表视图的各组行数
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"");
    
    return 5;
}

/**
 列表视图的行视图
 
 @param tableView 列表视图
 @param indexPath 列表视图某行的索引值
 @return 列表视图某行视图
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    // 数据data
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    // 视图cell
    GQHHomeTableViewCell *cell = [GQHHomeTableViewCell qh_tableView:tableView cellWithData:data];
    cell.qh_delegate = self;
    
    return cell;
}

#pragma mark - UITableViewDelegate
/**
 列表视图的各行高度
 
 @param tableView 列表视图
 @param indexPath 列表视图某行的索引值
 @return 列表视图某行视图的高度值
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    return 50.0f;
}

/**
 选中列表视图的某行视图
 
 @param tableView 列表视图
 @param indexPath 选中列表视图的某行视图的索引值
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 列表视图的组头视图高度
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组头视图高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSLog(@"");
    
    return CGFLOAT_MIN;
}

/**
 列表视图的组自定义头视图
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组自定义头视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSLog(@"");
    
    // 头视图数据data
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    // 自定义头视图
    GQHHomeTableViewHeaderView *headerView = [GQHHomeTableViewHeaderView qh_tableView:tableView headerViewWithData:data];
    headerView.qh_delegate = self;
    
    return headerView;
}

/**
 列表视图的组尾视图高度
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组尾视图高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSLog(@"");
    
    return CGFLOAT_MIN;
}

/**
 列表视图的组自定义尾视图
 
 @param tableView 列表视图
 @param section 列表视图的某组索引值
 @return 列表视图的某组自定义尾视图
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSLog(@"");
    
    // 尾视图数据data
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    // 自定义尾视图
    GQHHomeTableViewFooterView *footerView = [GQHHomeTableViewFooterView qh_tableView:tableView footerViewWithData:data];
    footerView.qh_delegate = self;
    
    return footerView;
}

#pragma mark - GQHHomeViewDelegate

/**
 跳转关于我们页面
 */
- (void)qh_forwardAboutUsPage {
    NSLog(@"");
    
    GQHAppAboutController *appAboutController = [[GQHAppAboutController alloc] init];
    [self.navigationController pushViewController:appAboutController animated:YES];
}

/**
 跳转游戏记录页面
 */
- (void)qh_forwardRecordsPage {
    NSLog(@"");
    
    GQHRecordsController *recordsController = [[GQHRecordsController alloc] init];
    [self.navigationController pushViewController:recordsController animated:YES];
}

/**
 跳转开始游戏页面
 */
- (void)qh_forwardGamePage {
    NSLog(@"");
    
    GQHGameController *gameController = [[GQHGameController alloc] init];
    [self.navigationController pushViewController:gameController animated:YES];
}

/**
 跳转图库页面
 */
- (void)qh_forwardGallaryPage {
    NSLog(@"");
    
    GQHGalleryController *galleryController = [[GQHGalleryController alloc] init];
    [self.navigationController pushViewController:galleryController animated:YES];
}

/**
 跳转游戏等级页面
 */
- (void)qh_forwardLevelsPage {
    NSLog(@"");
    
    GQHLevelsController *levelsController = [[GQHLevelsController alloc] init];
    [self.navigationController pushViewController:levelsController animated:YES];
}

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

#pragma mark - Setter

#pragma mark - Getter
- (GQHHomeView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHHomeView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.backgroundColor = [UIColor whiteColor];
        _rootView.qh_tableView.delegate = self;
        _rootView.qh_tableView.dataSource = self;
        _rootView.qh_delegate = self;
    }
    
    return _rootView;
}

- (NSMutableArray *)dataSourceArray {
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray array];
    }
    
    return _dataSourceArray;
}

@end
