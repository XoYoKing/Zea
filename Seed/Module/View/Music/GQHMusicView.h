//
//  GQHMusicView.h
//  Seed
//
//  Created by GuanQinghao on 09/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GQHMusicViewDelegate <NSObject>

@required

@optional

@end


@interface GQHMusicView : UIView

/// 视图代理
@property (nonatomic, weak) id<GQHMusicViewDelegate> qh_delegate;
/// 背景音乐视图列表
@property (nonatomic, strong) UITableView *qh_tableView;

@end

/// 背景音乐Cell
@interface GQHMusicViewCell : UITableViewCell


@end

