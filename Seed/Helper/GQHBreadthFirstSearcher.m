//
//  GQHBreadthFirstSearcher.m
//  Seed
//
//  Created by Mac on 2019/11/6.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBreadthFirstSearcher.h"


@implementation GQHBreadthFirstSearcher

- (NSMutableArray *)qh_startSearching {
    
    NSMutableArray *path = [super qh_startSearching];
    
    if (!path) {
        
        return nil;
    }
    
    // 关闭堆
    NSMutableDictionary *close = [NSMutableDictionary dictionary];
    // 开放队列
    NSMutableArray *open = [NSMutableArray array];
    
    [open addObject:self.qh_startStatus];
    
    
    while (open.count > 0) {
        
        // 出列
        id status = [open firstObject];
        [open removeObjectAtIndex:0];
        
        // 排除已经搜索过的状态
        NSString *statusIdentifier = [status qh_statusIdentifier];
        if (close[statusIdentifier]) {
            
            continue;
        }
        
        // 如果找到目标状态
        if (self.qh_comparator(self.qh_targetStatus, status)) {
            
            path = [self qh_constructPathWithStatus:status isLast:NO];
            break;
        }
        
        // 扩展子状态
        [open addObjectsFromArray:[status qh_status]];
    }
    
    NSLog(@"总共搜索: %@个状态",@(close.count));
    
    return path;
}

@end
