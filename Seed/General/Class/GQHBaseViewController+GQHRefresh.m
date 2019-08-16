//
//  GQHBaseViewController+GQHRefresh.m
//  Seed
//
//  Created by Mac on 2019/5/16.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseViewController+GQHRefresh.h"
#import "GQHHeader.h"


@implementation GQHBaseViewController (GQHRefresh)

/**
 设置并立即刷新

 @param view 滚动视图
 @param handler 刷新时的操作
 */
- (void)qh_beginRefreshingWith:(UIView *)view handler:(void(^)(void))handler {
    
    if ([view isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UITableView *)view;
        scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.qh_pageNumber = 1;
            if (handler) {
                
                handler();
            }
        }];
        
        scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            if (self.qh_lastPage) {
                
                [self showToastWithText:NSLocalizedString(@"最后一页", @"最后一页")];
                [self qh_view:scrollView endRefresh:@{}];
            } else {
                
                self.qh_pageNumber += 1;
                
                if (handler) {
                    
                    handler();
                }
            }
        }];
        
        [scrollView.mj_header beginRefreshing];
    }
}

/**
 开始刷新
 
 @param view 滚动视图及其子类
 */
- (void)qh_startRefresh:(__kindof UIScrollView *)view {
    
    [view.mj_header beginRefreshing];
}

/**
 结束刷新

 @param view 滚动视图及其子类
 @param response 刷新返回数据(直接与页码相关的数据)
 */
- (void)qh_view:(UIScrollView *)view endRefresh:(id)response {
    
    // 根据页码
    if ([NSObject qh_isValidDictionary:response]) {
        
        if (response[@"current"]) {
            
            NSInteger current = [response[@"current"] integerValue];
            NSInteger pages = [response[@"pages"] integerValue];
            
            if (current >= pages) {
                
                self.qh_lastPage = YES;
            }
        }
    }
    
    [view.mj_header endRefreshing];
    [view.mj_footer endRefreshing];
}

#pragma mark - 属性关联
- (void)setQh_pageNumber:(NSInteger)qh_pageNumber {
    
    NSNumber *pageNumber = [NSNumber numberWithInteger:qh_pageNumber];
    objc_setAssociatedObject(self, @selector(qh_pageNumber), pageNumber, OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)qh_pageNumber {
    
    NSNumber *pageNumber = objc_getAssociatedObject(self, _cmd);
    
    return ([pageNumber integerValue] <= 1) ? 1 : [pageNumber integerValue];
}

- (void)setQh_lastPage:(BOOL)qh_lastPage {
    
    NSNumber *lastPage = [NSNumber numberWithInteger:qh_lastPage];
    objc_setAssociatedObject(self, @selector(qh_lastPage), lastPage, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)qh_lastPage {
    
    NSNumber *lastPage = objc_getAssociatedObject(self, _cmd);
    
    return [lastPage boolValue];
}

@end
