//
//  GQHRecordView.h
//  Seed
//
//  Created by GuanQinghao on 09/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GQHRecordViewDelegate <NSObject>

@required

@optional

@end


@interface GQHRecordView : UIView

/// 视图代理
@property (nonatomic, weak) id<GQHRecordViewDelegate> qh_delegate;
/// 游戏记录视图列表
@property (nonatomic, strong) UITableView *qh_tableView;

@end


/// 游戏记录Cell
@interface GQHRecordViewCell : UITableViewCell


@end
