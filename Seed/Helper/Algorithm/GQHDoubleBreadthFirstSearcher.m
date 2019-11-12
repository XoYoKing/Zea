//
//  GQHDoubleBreadthFirstSearcher.m
//  Seed
//
//  Created by Mac on 2019/11/7.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHDoubleBreadthFirstSearcher.h"


@implementation GQHDoubleBreadthFirstSearcher

- (NSMutableArray *)qh_startSearching {
    
    NSMutableArray *path = [super qh_startSearching];
    
    if (!path) {
        
        return nil;
    }
    
    // 关闭堆, 存放已搜索过的状态
    NSMutableDictionary *positiveClose = [NSMutableDictionary dictionary];
    NSMutableDictionary *negativeClose = [NSMutableDictionary dictionary];
    
    // 开放队列, 存放由已搜索d过的状态k所扩展出来的未搜索状态
    NSMutableArray *positiveOpen = [NSMutableArray array];
    NSMutableArray *negativeOpen = [NSMutableArray array];
    
    [positiveOpen addObject:self.qh_startStatus];
    [negativeOpen addObject:self.qh_targetStatus];
    
    while (positiveOpen.count > 0 || negativeOpen.count > 0) {
        
        // 较短的那个扩展队列
        NSMutableArray *open;
        // 短队列对应的关闭堆
        NSMutableDictionary *close;
        // 另一个关闭堆
        NSMutableDictionary *anotherClose;
        // 找出短队列
        if (positiveOpen.count && (positiveOpen.count < negativeOpen.count)) {
            
            open = positiveOpen;
            close = positiveClose;
            anotherClose = negativeClose;
        } else {
            
            open = negativeOpen;
            close = negativeClose;
            anotherClose = positiveClose;
        }
        
        // 出列
        id status = [open firstObject];
        [open removeObjectAtIndex:0];
        
        // 排除已经搜索过的状态
        NSString *statusIdentifier = [status qh_statusIdentifier];
        if (close[statusIdentifier]) {
            
            continue;
        }
        
        close[statusIdentifier] = status;
        
        // 如果本状态同时存在于另一个已检查堆，则说明正反两棵搜索树出现交叉, 搜索结束
        if (anotherClose[statusIdentifier]) {
            
            NSMutableArray *positivePath = [self  qh_constructPathWithStatus:positiveClose[statusIdentifier] isLast:YES];
            NSMutableArray *negativePath = [self qh_constructPathWithStatus:negativeClose[statusIdentifier] isLast:NO];
            
            // 拼接正反两条路径
            [positivePath addObjectsFromArray:negativePath];
            path = positivePath;
            
            break;
        }
        
        // 否则扩展出子状态
        [open addObjectsFromArray:[status qh_status]];
    }
    
    NSLog(@"总共搜索: %@个状态",@(positiveClose.count + negativeClose.count - 1));
    
    return path;
}

@end
