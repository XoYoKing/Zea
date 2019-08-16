//
//  GQHBaseViewController+GQHRefresh.h
//  Seed
//
//  Created by Mac on 2019/5/16.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface GQHBaseViewController (GQHRefresh)

/**
 下拉刷新上拉加载当前页码
 */
@property (nonatomic, assign) NSInteger qh_pageNumber;

/**
 是否是最后一页
 */
@property (nonatomic, assign) BOOL qh_lastPage;

/**
 设置并立即刷新
 
 @param view 滚动视图
 @param handler 刷新时的操作
 */
- (void)qh_beginRefreshingWith:(UIView *)view handler:(void(^)(void))handler;

/**
 开始刷新
 
 @param view 滚动视图及其子类
 */
- (void)qh_startRefresh:(__kindof UIScrollView *)view;

/**
 结束刷新
 
 @param view 滚动视图及其子类
 @param response 刷新返回数据(直接与页码相关的数据)
 */
- (void)qh_view:(UIScrollView *)view endRefresh:(id)response;

@end

NS_ASSUME_NONNULL_END
