//
//  GQHPuzzleStatus.h
//  Seed
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GQHPathSearcher.h"
#import "GQHAStarSearcher.h"
#import "GQHPuzzlePiece.h"

NS_ASSUME_NONNULL_BEGIN

/// 表示游戏过程中, 某一个时刻, 所有拼图块的排列状态
@interface GQHPuzzleStatus : NSObject <GQHPathSearcherStatus,GQHAStarSearcherStatus>

/// 阶数
@property (nonatomic, assign) NSInteger qh_order;

/// 拼图块数组, 顺序排列, 从上到下, 从左到右
@property (nonatomic, strong) NSMutableArray<GQHPuzzlePiece *> *qh_puzzlePieceArray;

/// 空拼图块的位置, 没有空拼图块的时候为-1
@property (nonatomic, assign) NSInteger qh_mark;

/// 创建排列状态
/// @param order 阶数
/// @param image 图片
+ (instancetype)qh_puzzleStatusWithOrder:(NSInteger)order image:(UIImage *)image;

/// 复制排列状态
- (instancetype)qh_copy;

/// 是否与另一个状态相同
/// @param status 排列状态
- (BOOL)qh_isEqualTo:(GQHPuzzleStatus *)status;

/// 打乱拼图
/// @param count 随机移动的步数
- (void)qh_shuffle:(NSInteger)count;

/// 移除所有拼图块
- (void)qh_removeAllPieces;

/// 空拼图块是否能移动到某个位置
/// @param position 位置对应的序号
- (BOOL)qh_canMoveTo:(NSInteger)position;

/// 把空拼图块移动到某个位置
/// @param position 位置对应的序号
- (void)qh_moveTo:(NSInteger)position;

@end

NS_ASSUME_NONNULL_END
