//
//  GQHPriorityQueue.m
//  Seed
//
//  Created by Mac on 2019/11/5.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHPriorityQueue.h"


@interface GQHPriorityQueue ()

/// 队列数据
@property (nonatomic, strong) NSMutableArray *data;

/// 尾元素索引值
@property (nonatomic, assign) NSInteger tailIndex;

@end


@implementation GQHPriorityQueue

/// 创建队列
/// @param comparator 比较器
+ (instancetype)qh_queueWithComparator:(GQHPriorityQueueComparator)comparator {
    
    return [self qh_queueWithData:nil comparator:comparator];
}

/// 创建队列
/// @param data 队列数据
/// @param comparator 比较器
+ (instancetype)qh_queueWithData:(nullable NSArray *)data comparator:(GQHPriorityQueueComparator)comparator {
    
    GQHPriorityQueue *queue = [[GQHPriorityQueue alloc] init];
    
    if (data) {
        
        [queue.data addObjectsFromArray:data];
    }
    
    queue.qh_comparator = comparator;
    
    return queue;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.data = [NSMutableArray array];
        
        // 第0位不使用
        [self.data addObject:[NSNull null]];
    }
    
    return self;
}

/// 入列
/// @param element 入列数据元素
- (void)qh_enqueue:(id)element {
    
    // 添加到队尾
    [self.data addObject:element];
    
    // 上浮元素，维持大顶堆
    [self goUp:self.tailIndex];
}

/// 元素上浮
/// @param index 需要上浮的元素索引值
- (void)goUp:(NSInteger)index {
    
    // 临时存储需要上浮的元素
    id temp = self.data[index];
    
    // 大顶堆的性质
    // 1、N号元素的父节点的位置为N/2
    // 2、N号元素的左孩子的位置是2N, 右孩子的位置是2N+1
    
    for (NSInteger parentIndex = index / 2; parentIndex >= 1; parentIndex /= 2) {
        
        // 上浮条件: 元素大于父节点
        if (self.qh_comparator(temp,self.data[parentIndex]) != NSOrderedDescending) {
            
            break;
        }
        
        // 父节点元素下沉
        self.data[index] = self.data[parentIndex];
        
        // 元素新的索引值
        index = parentIndex;
    }
    
    // 元素上浮到目标位置
    self.data[index] = temp;
}

/// 出列
- (id)qh_dequeue {
    
    if (self.qh_count == 0) {
        
        return nil;
    }
    
    // 取根元素
    id element = self.data[1];
    
    // 交换队首和队尾元素
    [self swap:1 with:self.tailIndex];
    [self.data removeLastObject];
    
    if (self.data.count > 1) {
        
        // 下沉刚刚交换的队尾元素, 维持大顶堆
        [self goDown:1];
    }
    
    return element;
}

/// 交换数据元素
/// @param index 元素索引值
/// @param another 元素索引值
- (void)swap:(NSInteger)index with:(NSInteger)another {
    
    id temp = self.data[index];
    self.data[index] = self.data[another];
    self.data[another] = temp;
}

/// 元素下沉
/// @param index 需要下沉的元素索引值
- (void)goDown:(NSInteger)index {
    
    // 临时存储需要下沉的元素
    id temp = self.data[index];
    
    // 默认左孩子节点
    for (NSInteger childIndex = index * 2; childIndex <= self.tailIndex; childIndex *= 2) {
        
        // 如果存在右孩子节点且左孩子节点比右孩子节点小
        if (childIndex < self.tailIndex && (self.qh_comparator(self.data[childIndex], self.data[childIndex + 1]) == NSOrderedAscending)) {
            
            // 取右孩子节点
            childIndex++;
        }
        
        // 下沉条件: 元素小于孩子节点
        if (self.qh_comparator(temp, self.data[childIndex]) != NSOrderedAscending) {
            
            break;
        }
        
        // 孩子节点上浮
        self.data[index] = self.data[childIndex];
        
        // 元素新的索引值
        index = childIndex;
    }
    
    // 元素下沉到目标位置
    self.data[index] = temp;
}

/// 清空队列
- (void)qh_clearQueue {
    
    [self.data removeAllObjects];
    [self.data addObject:[NSNull null]];
}

/// 打印队列
- (void)qh_printQueueWithMessage:(nullable NSString *)message {
    
    NSMutableString *string = [NSMutableString string];
    
    [self.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [string appendFormat:@" %@",obj];
    }];
    
    NSLog(@"%@:%@",message, string);
}

/// 获取队列数据
- (NSArray *)qh_fetchQueueData {
    
    return [self.data subarrayWithRange:NSMakeRange(1, self.tailIndex)];
}

#pragma mark - Getter

- (NSInteger)qh_count {
    
    return self.data.count - 1;
}

- (NSInteger)tailIndex {
    
    return self.data.count - 1;
}

@end
