//
//  GQHPathSearcher.m
//  Seed
//
//  Created by Mac on 2019/11/6.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHPathSearcher.h"


@implementation GQHPathSearcher

- (NSMutableArray *)qh_startSearching {
    
    if (!self.qh_startStatus || !self.qh_targetStatus || !self.qh_comparator) {
        
        return nil;
    }
    
    return [NSMutableArray array];
}

- (NSMutableArray *)qh_constructPathWithStatus:(id<GQHPathSearcherStatus>)status isLast:(BOOL)isLast {
    
    NSMutableArray *path = [NSMutableArray array];
    
    if (!status) {
        
        return path;
    }
    
    do {
        
        if (isLast) {
            
            [path insertObject:status atIndex:0];
        } else {
            
            [path addObject:status];
        }
        
        status = [status qh_superStatus];
    } while (status);
    
    return path;
}

#pragma mark - Setter

- (void)setQh_startStatus:(id<GQHPathSearcherStatus>)qh_startStatus {
    
    // 开始状态没有父状态
    [qh_startStatus setQh_superStatus:nil];
    _qh_startStatus = qh_startStatus;
}

- (void)setQh_targetStatus:(id<GQHPathSearcherStatus>)qh_targetStatus {
    
    // 目标状态没有父状态
    [qh_targetStatus setQh_superStatus:nil];
    _qh_targetStatus = qh_targetStatus;
}

@end
