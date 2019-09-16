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
 当前页码
 */
@property (nonatomic, assign) NSInteger qh_pageNumber;

/**
 是否是最后一页
 */
@property (nonatomic, assign) BOOL qh_lastPage;

/**
 设置并立即刷新

 @param scrollView 视图
 @param handler 刷新时的操作
 */
- (void)qh_beginRefreshingWith:(__kindof UIScrollView *)scrollView handler:(void(^)(void))handler;

/**
 开始刷新

 @param scrollView 视图
 */
- (void)qh_startRefresh:(__kindof UIScrollView *)scrollView;


/**
 结束刷新

 @param scrollView 视图
 @param response 刷新返回数据(直接与页码相关的数据)
 */
- (void)qh_scrollView:(__kindof UIScrollView *)scrollView endRefresh:(nullable id)response;

@end

NS_ASSUME_NONNULL_END
