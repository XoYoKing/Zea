//
//  GQHAStarSearcher.h
//  Seed
//
//  Created by Mac on 2019/11/7.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHPathSearcher.h"


NS_ASSUME_NONNULL_BEGIN

/// A*搜索状态协议
@protocol GQHAStarSearcherStatus <GQHPathSearcherStatus>

@required

/// 从起始状态到当前状态的代价
@property (nonatomic, assign) NSInteger qh_g;

/// 从当前状态到目标状态的估算代价
@property (nonatomic, assign) NSInteger qh_h;

/// 总代价 f = g + h
@property (nonatomic, assign) NSInteger qh_f;

/// 估价函数, 估算从当前状态到目标状态的代价
/// @param targetStatus 目标状态
- (NSInteger)qh_estimateCostForTargetStatus:(id<GQHPathSearcherStatus>)targetStatus;

@optional

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface GQHAStarSearcher : GQHPathSearcher

@end

NS_ASSUME_NONNULL_END
