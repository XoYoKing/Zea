//
//  GQHPuzzlePiece.h
//  Seed
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GQHPuzzlePiece : UIButton

/// 拼图块在原图上的正确位置, 从0开始编号
@property (nonatomic, assign) NSInteger qh_position;

/// 创建拼图块
/// @param position 拼图块的位置
/// @param image 拼图块的图片
+ (instancetype)qh_puzzlePiece:(NSInteger)position image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
