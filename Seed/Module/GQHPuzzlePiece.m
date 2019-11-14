//
//  GQHPuzzlePiece.m
//  Seed
//
//  Created by Mac on 2019/11/8.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHPuzzlePiece.h"


@implementation GQHPuzzlePiece

+ (instancetype)qh_puzzlePiece:(NSInteger)position image:(UIImage *)image {
    
    GQHPuzzlePiece *puzzlePiece = [[GQHPuzzlePiece alloc] init];
    puzzlePiece.qh_position = position;
    [puzzlePiece setBackgroundImage:image forState:UIControlStateNormal];
    
    puzzlePiece.layer.borderWidth = 1.0f;
    puzzlePiece.layer.borderColor = UIColor.whiteColor.CGColor;
    
    return puzzlePiece;
}

@end
