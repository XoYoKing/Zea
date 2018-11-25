//
//  GQHLevelController.m
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
#import "GQHLevelView.h"

#pragma mark Controller
#import "GQHLevelController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------


@interface GQHLevelController () <UITableViewDelegate, UITableViewDataSource>

/// 自定义根视图
@property (nonatomic, strong) GQHLevelView *rootView;
/// 等级菜单数组
@property (nonatomic, strong) NSArray *levelImageArray;

@end


@implementation GQHLevelController

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
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"level", @"游戏等级") forState:UIControlStateNormal];
    self.qh_rightMostButton.hidden = YES;
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
    
    return self.levelImageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 0.4f * self.rootView.qh_width;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"GQHLevelCell";
    GQHLevelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHLevelViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.qh_levelImageView.image = [UIImage imageNamed:self.levelImageArray[indexPath.row]];
    
    /// 进入菜单页面默认选中Cell
    NSNumber *levelValue = [NSUserDefaults.standardUserDefaults objectForKey:GQHUserLevelKey];
    switch (levelValue.integerValue) {
        case GQHUserLevelEasy: {
            
            [self.rootView.qh_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
            break;
        case GQHUserLevelNormal: {
            
            [self.rootView.qh_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
            break;
        case GQHUserLevelHarder: {
            
            [self.rootView.qh_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
            break;
        case GQHUserLevelHardest: {
            
            [self.rootView.qh_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: {
            /// 游戏等级-简单 (3 X 3)
            NSNumber *levelValue = [NSNumber numberWithInteger:GQHUserLevelEasy];
            [NSUserDefaults.standardUserDefaults setObject:levelValue forKey:GQHUserLevelKey];
            [NSUserDefaults.standardUserDefaults synchronize];
        }
            break;
        case 1: {
            /// 游戏等级-正常 (4 X 4)
            NSNumber *levelValue = [NSNumber numberWithInteger:GQHUserLevelNormal];
            [NSUserDefaults.standardUserDefaults setObject:levelValue forKey:GQHUserLevelKey];
            [NSUserDefaults.standardUserDefaults synchronize];
        }
            break;
        case 2: {
            /// 游戏等级-困难 (6 X 6)
            NSNumber *levelValue = [NSNumber numberWithInteger:GQHUserLevelHarder];
            [NSUserDefaults.standardUserDefaults setObject:levelValue forKey:GQHUserLevelKey];
            [NSUserDefaults.standardUserDefaults synchronize];
        }
            break;
        case 3: {
            /// 游戏等级-极难 (8 X 8) (仅 iPad)
            NSNumber *levelValue = [NSNumber numberWithInteger:GQHUserLevelHardest];
            [NSUserDefaults.standardUserDefaults setObject:levelValue forKey:GQHUserLevelKey];
            [NSUserDefaults.standardUserDefaults synchronize];
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

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (GQHLevelView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHLevelView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.qh_tableView.delegate = self;
        _rootView.qh_tableView.dataSource = self;
    }
    
    return _rootView;
}

- (NSArray *)levelImageArray {
    
    if (!_levelImageArray) {
        
        _levelImageArray = @[@"level_easy",@"level_medium",@"level_hard",@""];
    }
    
    return _levelImageArray;
}

@end
