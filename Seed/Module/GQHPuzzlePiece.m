//
//  GQHPuzzlePiece.m
//  Seed
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHPuzzlePiece.h"
#import "UIButton+GQHButton.h"


@implementation GQHPuzzlePiece

+ (instancetype)qh_puzzlePiece:(NSInteger)position image:(UIImage *)image {
    
    GQHPuzzlePiece *puzzlePiece = [[GQHPuzzlePiece alloc] init];
    puzzlePiece.qh_position = position;
    [puzzlePiece setBackgroundImage:image forState:UIControlStateNormal];
    [puzzlePiece setBackgroundImage:image forState:UIControlStateHighlighted];
    
    puzzlePiece.layer.borderWidth = 0.5f;
    puzzlePiece.layer.borderColor = UIColor.whiteColor.CGColor;
    
    //MARK:按钮重复点击冲突
    puzzlePiece.qh_timeIntervalOnclick = 0.15f;
    
    return puzzlePiece;
}

@end
