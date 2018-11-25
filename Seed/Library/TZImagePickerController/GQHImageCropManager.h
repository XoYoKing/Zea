//
//  GQHImageCropManager.h
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GQHImageCropManager : NSObject

// 裁剪框蒙版
+ (void)qh_clippingMaskWithView:(UIView *)view clipRect:(CGRect)clipRect circular:(BOOL)isCircular;

// 获得裁剪后的图片
+ (UIImage *)qh_clipImageView:(UIImageView *)imageView withContainerView:(UIView *)containerView rect:(CGRect)rect scale:(double)scale;

// 获取裁剪后的圆形图片
+ (UIImage *)qh_clipRoundImage:(UIImage *)image;

@end



