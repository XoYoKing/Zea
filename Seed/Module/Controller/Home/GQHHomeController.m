//
//  GQHHomeController.m
//  Seed
//
//  Created by GuanQinghao on 25/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#pragma mark Macro
#import "GQHHeader.h"

#pragma mark Model

#pragma mark Object

#pragma mark View
#import "GQHHomeView.h"

#pragma mark Controller
#import "GQHHomeController.h"
#import "GQHAboutController.h"
#import "GQHRecordController.h"
#import "GQHGameController.h"
#import "GQHLevelController.h"
#import "GQHGalleryController.h"
#import "GQHMusicController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------


@interface GQHHomeController () <UITableViewDelegate, UITableViewDataSource>

/// 自定义根视图
@property (nonatomic, strong) GQHHomeView *rootView;
/// 菜单标题数组
@property (nonatomic, strong) NSArray *menuTitleArray;
/// 菜单副标题数组
@property (nonatomic, strong) NSArray *menuSubtitleArray;

@end


@implementation GQHHomeController

#pragma mark --Lifecycle
- (void)loadView {
    // 添加自定义视图
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
    
    [self.qh_backButton setBackgroundImage:[UIImage imageNamed:@"home_about"] forState:UIControlStateNormal];
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"puzzle", @"拼图") forState:UIControlStateNormal];
    
    [self.qh_rightMostButton setBackgroundImage:[UIImage imageNamed:@"home_record"] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog();
    
}

#pragma mark --Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuTitleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 0.4f * self.rootView.qh_width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"GQHHomeCell";
    GQHHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHHomeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.qh_titleLabel.text = self.menuTitleArray[indexPath.row];
    cell.qh_subTitleLabel.text = self.menuSubtitleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            
        case 0: {
            
            // 开始游戏
            GQHGameController *gameController = [[GQHGameController alloc] init];
            [self.navigationController pushViewController:gameController animated:YES];
        }
            break;
        case 1: {
            
            // 游戏难度
            GQHLevelController *levelController = [[GQHLevelController alloc] init];
            [self.navigationController pushViewController:levelController animated:YES];
        }
            break;
        case 2: {
            
            // 游戏图库
            GQHGalleryController *galleryController = [[GQHGalleryController alloc] init];
            [self.navigationController pushViewController:galleryController animated:YES];
        }
            break;
        case 3: {
            
            // 背景音乐
            GQHMusicController *musicController = [[GQHMusicController alloc] init];
            [self.navigationController pushViewController:musicController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return GQHFrameSingleMargin;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

#pragma mark --TargetMethod
- (void)qh_clickedBackButton:(UIButton *)sender {
    
    GQHAboutController *aboutController = [[GQHAboutController alloc] init];
    [self.navigationController pushViewController:aboutController animated:YES];
}

- (void)qh_clickedRightMostButton:(UIButton *)sender {
    
    GQHRecordController *recordController = [[GQHRecordController alloc] init];
    [self.navigationController pushViewController:recordController animated:YES];
}

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (GQHHomeView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHHomeView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.backgroundColor = UIColor.whiteColor;
        _rootView.qh_tableView.delegate = self;
        _rootView.qh_tableView.dataSource = self;
    }
    
    return _rootView;
}

- (NSArray *)menuTitleArray {
    
    if (!_menuTitleArray) {
        
        _menuTitleArray = @[@"开始游戏",@"选择模式",@"游戏图库",@"游戏音效"];
    }
    
    return _menuTitleArray;
}

- (NSArray *)menuSubtitleArray {
    
    if (!_menuSubtitleArray) {
        
        _menuSubtitleArray = @[@"开始挑战自己吧",@"选择一个适合你的难度",@"你需要一张好看的图片",@"来点音乐嗨起来"];
    }
    
    return _menuSubtitleArray;
}

@end
