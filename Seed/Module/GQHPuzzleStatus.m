//
//  GQHPuzzleStatus.m
//  Seed
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHPuzzleStatus.h"

@interface GQHPuzzleStatus () {
    
    /// 父状态
    id<GQHPathSearcherStatus> _qh_superStatus;
    
    /// 从起始状态到当前状态的代价
    NSInteger _g;
    
    /// 从当前状态到目标状态的估算代价
    NSInteger _h;
    
    /// 总代价 f = g + h
    NSInteger _f;
}

@end

@implementation GQHPuzzleStatus

+ (instancetype)qh_puzzleStatusWithOrder:(NSInteger)order image:(UIImage *)image {
    
    if (order < 3 || !image) {
        
        return nil;
    }
    
    GQHPuzzleStatus *status = [[GQHPuzzleStatus alloc] init];
    status.qh_order = order;
    status.qh_puzzlePieceArray = [NSMutableArray arrayWithCapacity:order * order];
    status.qh_mark = -1;
    
    CGFloat width = image.size.width / order;
    CGFloat height = image.size.height / order;
    
    NSInteger sequence = 0;
    for (NSInteger row = 0; row < order; row++) {
        
        for (NSInteger column = 0; column < order; column++) {
            
            // 切割图片
            CGRect rect = CGRectMake(column * width, row * height, width, height);
            //TODO:需要释放吗?
            CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
            GQHPuzzlePiece *puzzlePiece = [GQHPuzzlePiece qh_puzzlePiece:sequence++ image:[UIImage imageWithCGImage:imageRef]];
            [status.qh_puzzlePieceArray addObject:puzzlePiece];
        }
    }
    
    return status;
}

- (instancetype)qh_copy {
    
    GQHPuzzleStatus *status = [[GQHPuzzleStatus alloc] init];
    status.qh_order = self.qh_order;
    status.qh_puzzlePieceArray = [self.qh_puzzlePieceArray mutableCopy];
    status.qh_mark = self.qh_mark;
    
    return status;
}

- (BOOL)qh_isEqualTo:(GQHPuzzleStatus *)status {
    
    return [self.qh_puzzlePieceArray isEqualToArray:status.qh_puzzlePieceArray];
}

- (void)qh_removeAllPieces {
    
    [self.qh_puzzlePieceArray enumerateObjectsUsingBlock:^(GQHPuzzlePiece * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
}

- (void)qh_shuffle:(NSInteger)count {
    
    // 记录前置状态, 避免来回移动
    // 前两个状态的空拼图位置
    NSInteger ancestorMark = -1;
    // 前一个状态的空拼图位置
    NSInteger parentMark = -1;
    
    while (count > 0) {
        
        NSInteger target = -1;
        
        switch (arc4random()%4) {
                
            case 0: {
                
                target = [self abovePosition];
            }
                break;
            case 1: {
                
                target = [self belowPosition];
            }
                break;
            case 2: {
                
                target = [self leftPosition];
            }
                break;
            case 3: {
                
                target = [self rightPosition];
            }
                break;
            default:
                break;
        }
        
        if (target != -1 && target != ancestorMark) {
            
            [self qh_moveTo:target];
            ancestorMark = parentMark;
            parentMark = target;
            count--;
        }
    }
}

- (BOOL)qh_canMoveTo:(NSInteger)position {
    
    // 能移动的条件
    // 1、没有超出边界
    // 2、空拼图块和目标位置处于同一行或同一列 且相邻
    BOOL canRow = ([self rowNumberOf:self.qh_mark] == [self rowNumberOf:position]) && (labs([self columnNumberOf:self.qh_mark] - [self columnNumberOf:position]) == 1);
    
    BOOL canColumn = ([self columnNumberOf:self.qh_mark] == [self columnNumberOf:position]) && (labs([self rowNumberOf:self.qh_mark] - [self rowNumberOf:position]) == 1);
    
    return (canRow || canColumn);
}

- (void)qh_moveTo:(NSInteger)position {
    
    GQHPuzzlePiece *mark = self.qh_puzzlePieceArray[self.qh_mark];
    self.qh_puzzlePieceArray[self.qh_mark] = self.qh_puzzlePieceArray[position];
    self.qh_puzzlePieceArray[position] = mark;
    
    self.qh_mark = position;
}

#pragma mark - PrivateMethod

/// 行号
/// @param position 位置
- (NSInteger)rowNumberOf:(NSInteger)position {
    
    return position / self.qh_order;
}

/// 列号
/// @param position 位置
- (NSInteger)columnNumberOf:(NSInteger)position {
    
    return position % self.qh_order;
}

/// 上面拼图块的位置
- (NSInteger)abovePosition {
    
    if ([self rowNumberOf:self.qh_mark] == 0) {
        
        return -1;
    }
    
    return self.qh_mark - self.qh_order;
}

/// 下面拼图块的位置
- (NSInteger)belowPosition {
    
    if ([self rowNumberOf:self.qh_mark] == self.qh_order - 1) {
        
        return -1;
    }
    
    return self.qh_mark + self.qh_order;
}

/// 左边拼图块的位置
- (NSInteger)leftPosition {
    
    if ([self columnNumberOf:self.qh_mark] == 0) {
        
        return -1;
    }
    
    return self.qh_mark - 1;
}

/// 右边拼图块的位置
- (NSInteger)rightPosition {
    
    if ([self columnNumberOf:self.qh_mark] == self.qh_order - 1) {
        
        return -1;
    }
    
    return self.qh_mark + 1;
}

#pragma mark - GQHPathSearcherStatus

- (NSString *)qh_statusIdentifier {
    
    NSMutableString *identifier = [NSMutableString string];
    [self.qh_puzzlePieceArray enumerateObjectsUsingBlock:^(GQHPuzzlePiece * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [identifier appendFormat:@"%ld",obj.qh_position];
    }];
    
    return identifier;
}

- (NSMutableArray<id<GQHPathSearcherStatus>> *)qh_status {
    
    NSMutableArray *status = [NSMutableArray array];
    NSInteger targetPositon = -1;
    
    if ((targetPositon = [self abovePosition]) != -1) {
        
        [self addPosition:targetPositon toChildStatus:status];
    }
    
    if ((targetPositon = [self belowPosition]) != -1) {
        
        [self addPosition:targetPositon toChildStatus:status];
    }
    
    if ((targetPositon = [self leftPosition]) != -1) {
        
        [self addPosition:targetPositon toChildStatus:status];
    }
    
    if ((targetPositon = [self rightPosition]) != -1) {
        
        [self addPosition:targetPositon toChildStatus:status];
    }
    
    return status;
}

- (void)addPosition:(NSInteger)position toChildStatus:(NSMutableArray *)childStatus {
    
    // 排除父状态
    if ([self qh_superStatus] && [(GQHPuzzleStatus *)[self qh_superStatus] qh_mark] == position) {
        
        return;
    }
    
    if (![self qh_canMoveTo:position]) {
        
        return;
    }
    
    GQHPuzzleStatus *status = [self qh_copy];
    [status qh_moveTo:position];
    [childStatus addObject:status];
    status.qh_superStatus = self;
}

- (void)setQh_superStatus:(id<GQHPathSearcherStatus>)qh_superStatus {
    
    _qh_superStatus = qh_superStatus;
}

- (id<GQHPathSearcherStatus>)qh_superStatus {
    
    return _qh_superStatus;
}











#pragma mark - GQHAStarSearcherStatus

/// 估价函数, 估算从当前状态到目标状态的代价
/// @param targetStatus 目标状态
- (NSInteger)qh_estimateCostForTargetStatus:(id<GQHPathSearcherStatus>)targetStatus {
    
    GQHPuzzleStatus *target = (GQHPuzzleStatus *)targetStatus;
    
    // 计算每一个拼图块距正确位置的距离
    // 曼哈顿距离
    NSInteger manhattanDistance = 0;
    for (NSInteger i = 0; i < self.qh_puzzlePieceArray.count; i++) {
        
        // 跳过空拼图块
        if (i == self.qh_mark) {
            
            continue;
        }
        
        GQHPuzzlePiece *currentPuzzlePiece = self.qh_puzzlePieceArray[i];
        GQHPuzzlePiece *targetPuzzlePiece = target.qh_puzzlePieceArray[i];
        
        manhattanDistance += ABS([self rowNumberOf:currentPuzzlePiece.qh_position] - [target rowNumberOf:targetPuzzlePiece.qh_position]) + ABS([self columnNumberOf:currentPuzzlePiece.qh_position] - [target columnNumberOf:targetPuzzlePiece.qh_position]);
    }
    
    // 增大权重
    return 5 * manhattanDistance;
}

- (void)setQh_g:(NSInteger)qh_g {
    
    _g = qh_g;
}

- (NSInteger)qh_g {
    
    return _g;
}

- (void)setQh_h:(NSInteger)qh_h {
    
    _h = qh_h;
}

- (NSInteger)qh_h {
    
    return _h;
}

- (void)setQh_f:(NSInteger)qh_f {
    
    _f = qh_f;
}

- (NSInteger)qh_f {
    
    return _f;
}












@end
