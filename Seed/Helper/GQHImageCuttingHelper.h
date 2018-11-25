//
//  GQHImageCuttingHelper.h
//  Seed
//
//  Created by GuanQinghao on 05/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GQHImageCuttingHelper : NSObject

// 分割、压缩并保存图片
+ (void)qh_cutImage:(UIImage *)image byRow:(NSInteger)row column:(NSInteger)col quality:(CGFloat)quality;

+ (UIImage *)qh_subImageOf:(UIImage *)image byRow:(NSInteger)row column:(NSInteger)column quality:(CGFloat)quality;

@end
