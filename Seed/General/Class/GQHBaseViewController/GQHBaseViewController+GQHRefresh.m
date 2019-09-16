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
 
 @param scrollView 视图
 @param handler 刷新时的操作
 */
- (void)qh_beginRefreshingWith:(__kindof UIScrollView *)scrollView handler:(void(^)(void))handler {
    
    if ([scrollView isKindOfClass:UIScrollView.class]) {
        
        // 下拉刷新
        scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.qh_lastPage = NO;
            self.qh_pageNumber = 1;
            
            if (handler) {
                
                handler();
            }
        }];
        
        // 上拉加载
        scrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            if (self.qh_lastPage) {
                
                [self showToastWithText:NSLocalizedString(@"最后一页", @"")];
                // 结束加载
                [self qh_scrollView:scrollView endRefresh:nil];
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
 
 @param scrollView 视图
 */
- (void)qh_startRefresh:(__kindof UIScrollView *)scrollView {
    
    [scrollView.mj_header beginRefreshing];
}


/**
 结束刷新
 
 @param scrollView 视图
 @param response 刷新返回数据(直接与页码相关的数据)
 */
- (void)qh_scrollView:(__kindof UIScrollView *)scrollView endRefresh:(id)response {
    
    if ([scrollView isKindOfClass:UIScrollView.class]) {
        
        if ([NSObject qh_isValidDictionary:response]) {
            
            // 当前页
            NSInteger current = [response[@"current"] integerValue];
            // 总页数
            NSInteger pages = [response[@"pages"] integerValue];
            
            // 最后一页
            if (current >= pages) {
                
                self.qh_lastPage = YES;
            }
            
            // 空白页设置
            
            NSInteger total = [response[@"total"] integerValue];
            if (0 == total) {
                
                // 空白页
            } else {
                
                
            }
        }
        
        [scrollView.mj_header endRefreshing];
        [scrollView.mj_footer endRefreshing];
    }
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
