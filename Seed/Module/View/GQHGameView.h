//
//  GQHGameView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseView.h"


/**
 自定义视图的代理
 */
@protocol GQHGameViewDelegate <NSObject>

@required

@optional

@end


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 自定义根视图
 */
@interface GQHGameView : GQHBaseView

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHGameViewDelegate> qh_delegate;

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 游戏板视图
 */
@property (nonatomic, strong) UIView *qh_gameboardView;

@end

NS_ASSUME_NONNULL_END
