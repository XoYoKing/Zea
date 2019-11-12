//
//  GQHAStarSearcher.m
//  Seed
//
//  Created by Mac on 2019/11/7.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHAStarSearcher.h"
#import "GQHPriorityQueue.h"


@implementation GQHAStarSearcher

- (NSMutableArray *)qh_startSearching {
    
    NSMutableArray *path = [super qh_startSearching];
    if (!path) {
        
        return nil;
    }
    
    id<GQHAStarSearcherStatus> status = (id<GQHAStarSearcherStatus>)[self qh_startStatus];
    [status setQh_g:0];
    
    // 关闭堆, 存放已搜索过的状态
    NSMutableDictionary *close = [NSMutableDictionary dictionary];
    
    // 开放队列, 存放由已搜索过的状态所扩展出来的未搜索状态
    // 使用优先队列
    GQHPriorityQueue *open = [GQHPriorityQueue qh_queueWithComparator:^NSComparisonResult(id<GQHAStarSearcherStatus>  _Nonnull obj1, id<GQHAStarSearcherStatus>  _Nonnull obj2) {
        
        if ([obj1 qh_f] == [obj2 qh_f]) {
            
            return NSOrderedSame;
        }
        
        // f值越小, 优先级越高
        return ([obj1 qh_f] < [obj2 qh_f]) ? NSOrderedDescending : NSOrderedAscending;
    }];
    
    [open qh_enqueue:self.qh_startStatus];
    
    while (open.qh_count > 0) {
        
        // 出列
        id status = [open qh_dequeue];
        
        // 排除已经搜索过的状态
        NSString *statusIdentifier = [status qh_statusIdentifier];
        
        if (close[statusIdentifier]) {
            
            continue;
        }
        close[statusIdentifier] = status;
        
        // 如果找到目标状态
        if (self.qh_comparator(self.qh_targetStatus, status)) {
            
            path = [self qh_constructPathWithStatus:status isLast:YES];
            break;
        }
        
        // 否则扩展出子状态
        NSMutableArray *childStatus = [status qh_status];
        // 对各个子状态进行代价估算
        [childStatus enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 子状态的实际代价比本状态大1
            [obj setQh_g:([status qh_g] + 1)];
            // 估算到目标状态的代价
            [obj setQh_h:[obj qh_estimateCostForTargetStatus:self.qh_targetStatus]];
            // 总代价 = 已知代价 + 估算代价
            [obj setQh_f:([obj qh_g] + [obj qh_h])];
            
            // 入列
            [open qh_enqueue:obj];
        }];
    }
    
    NSLog(@"总共搜索: %@个状态",@(close.count));
    
    return path;
}

@end
