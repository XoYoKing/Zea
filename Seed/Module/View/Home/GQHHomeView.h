//
//  GQHHomeView.h
//  Seed
//
//  Created by GuanQinghao on 08/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GQHHomeView : UIView

/// 菜单列表视图
@property (nonatomic, strong) UITableView *qh_tableView;

@end


/// 首页菜单Cell
@interface GQHHomeViewCell : UITableViewCell

/// 菜单标题
@property (nonatomic, strong) UILabel *qh_titleLabel;
/// 菜单副标题
@property (nonatomic, strong) UILabel *qh_subTitleLabel;

@end
