//
//  GQHPathSearcher.h
//  Seed
//
//  Created by Mac on 2019/11/6.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/// 状态协议
@protocol GQHPathSearcherStatus <NSObject>

@required

/// 父状态
@property (nonatomic, strong, nullable) id<GQHPathSearcherStatus>  qh_superStatus;

/// 此状态的唯一标识
- (NSString *)qh_statusIdentifier;

/// 取所有邻近状态(子状态)，排除父状态。每一个状态都需要给parentStatus赋值。
- (NSMutableArray<id<GQHPathSearcherStatus>> *)qh_status;

@optional

@end

/// 状态比较器
typedef BOOL (^GQHPathSearcherEqualComparator)(id<GQHPathSearcherStatus> status1, id<GQHPathSearcherStatus> status2);

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface GQHPathSearcher : NSObject

/// 开始状态
@property (nonatomic, strong) id<GQHPathSearcherStatus> qh_startStatus;

/// 目标状态
@property (nonatomic, strong) id<GQHPathSearcherStatus> qh_targetStatus;

/// 比较器
@property (nonatomic, strong) GQHPathSearcherEqualComparator qh_comparator;

/// 开始搜索, 返回搜索结果. 无法搜索时返回nil
- (NSMutableArray *)qh_startSearching;

/// 构建路径
/// @param status 状态
/// @param isLast 是否是最后一个
- (NSMutableArray *)qh_constructPathWithStatus:(id<GQHPathSearcherStatus>)status isLast:(BOOL)isLast;

@end

NS_ASSUME_NONNULL_END
