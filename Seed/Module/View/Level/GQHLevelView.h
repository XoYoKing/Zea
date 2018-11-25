//
//  GQHLevelView.h
//  Seed
//
//  Created by GuanQinghao on 09/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GQHLevelViewDelegate <NSObject>

@required

@optional

@end


@interface GQHLevelView : UIView

/// 视图代理
@property (nonatomic, weak) id<GQHLevelViewDelegate> qh_delegate;
/// 等级视图列表
@property (nonatomic, strong) UITableView *qh_tableView;

@end


/// 难度等级Cell
@interface GQHLevelViewCell : UITableViewCell

/// 等级菜单子视图
@property (nonatomic, strong) UIImageView *qh_levelImageView;

@end
