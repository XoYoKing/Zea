//
//  GQHPriorityQueue.h
//  Seed
//
//  Created by Mac on 2019/11/5.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NSComparisonResult(^GQHPriorityQueueComparator)(id _Nonnull obj1, id _Nonnull obj2);


NS_ASSUME_NONNULL_BEGIN

/// 优先队列，通过二叉堆实现，大顶堆(MaxHeap)
@interface GQHPriorityQueue : NSObject

/// 定义元素的比较逻辑
@property (nonatomic, copy) GQHPriorityQueueComparator qh_comparator;

/// 队列长度
@property (nonatomic, assign, readonly) NSInteger qh_count;


/// 创建队列
/// @param comparator 比较器
+ (instancetype)qh_queueWithComparator:(GQHPriorityQueueComparator)comparator;

/// 创建队列
/// @param data 队列数据
/// @param comparator 比较器
+ (instancetype)qh_queueWithData:(nullable NSArray *)data comparator:(GQHPriorityQueueComparator)comparator;

/// 入列
/// @param element 入列数据元素
- (void)qh_enqueue:(id)element;

/// 出列
- (nullable id)qh_dequeue;

/// 清空队列
- (void)qh_clearQueue;

/// 打印队列
- (void)qh_printQueueWithMessage:(nullable NSString *)message;

/// 获取队列数据
- (NSArray *)qh_fetchQueueData;

@end

NS_ASSUME_NONNULL_END
