//
//  GQHImageCuttingHelper.m
//  Seed
//
//  Created by GuanQinghao on 05/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHImageCuttingHelper.h"


@implementation GQHImageCuttingHelper

+ (void)qh_cutImage:(UIImage *)image byRow:(NSInteger)row column:(NSInteger)col quality:(CGFloat)quality {
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/pictures"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    
    if ((![image isKindOfClass:[UIImage class]])) {
        NSAssert(YES, @"illegal image format!");
    }
    if ((1 > row)) {
        NSAssert(YES, @"the row to separete image is wrong!");
    }
    if ((1 > col)) {
        NSAssert(YES, @"the col to separete image is wrong!");
    }
    
    CGFloat rowStep = image.size.height * 1.0f / row;
    CGFloat colStep = image.size.width * 1.0f / col;
    
    /*
     if ((rowStep != colStep)) {
     NSAssert(YES, @"the rowStep is not equal to colStep!");
     }
     */
    
    rowStep *= image.scale;
    colStep *= image.scale;
    
    for (NSInteger i = 0; i < row; i++) {
        for (NSInteger j = 0; j < col; j++) {
            
            CGRect rect = CGRectMake(colStep * j, rowStep * i, colStep, rowStep);
            CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rect);
            UIImage *partialImage = [UIImage imageWithCGImage:imageRef];
            NSString *imageString = [NSString stringWithFormat:@"pic_%02ld_%02ld.png",i,j];
            
            quality = (quality <= 0.0 || quality > 1.0) ? 1.0 :quality;
            
            [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
            NSString *imagePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",imageString]];
            NSData *imageData = UIImageJPEGRepresentation(partialImage, quality);
            [imageData writeToFile:imagePath atomically:YES];
        }
    }
}

@end
