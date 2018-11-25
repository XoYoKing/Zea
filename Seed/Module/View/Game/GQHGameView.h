//
//  GQHGameView.h
//  Seed
//
//  Created by GuanQinghao on 04/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GQHGameView : UIView

/// 预览视图
@property (nonatomic, strong) UIImageView *qh_previewImageView;
/// 最佳游戏时间
@property (nonatomic, strong) UILabel *qh_bestTimeTextLabel;
/// 最少游戏计数
@property (nonatomic, strong) UILabel *qh_leastCountTextLabel;
/// 当前游戏时间
@property (nonatomic, strong) UILabel *qh_timeTextLabel;
/// 当前游戏计数
@property (nonatomic, strong) UILabel *qh_countTextLabel;
/// 游戏区
@property (nonatomic, strong) UIView *qh_gameView;

@end
