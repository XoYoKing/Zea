//
//  UIImage+GQHImage.h
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger,GQHFlipDirection) {
    
    /// 垂直翻转
    GQHFlipDirectionVertical,
    /// 水平翻转
    GQHFlipDirectionHorizontal
};

@interface UIImage (GQHImage)

/// 纯色图片
+ (UIImage *)qh_imageWithColor:(UIColor *)color;
+ (UIImage *)qh_imageWithColor:(UIColor *)color size:(CGSize)size;
/// 灰度图片
- (UIImage *)qh_imageWithGrayscale;
/// 旋转图片
- (UIImage *)qh_imageRotatedWithDegrees:(CGFloat)degrees;
/// 翻转图片
- (UIImage *)qh_imageFlipedWithDirection:(GQHFlipDirection)direction;
/// 缩放图片指定尺寸
- (UIImage *)qh_imageRescaledWithSize:(CGSize)size;
/// 截图/截屏
+ (UIImage *)qh_imageFromView:(__kindof UIView *)view;


/// 添加图片水印
- (nonnull UIImage *)qh_watermarkImageWithRect:(CGRect)rect image:(nullable UIImage *)anImage;
/// 添加文字水印
- (nonnull UIImage *)qh_watermarkImageWithRect:(CGRect)rect string:(nullable NSAttributedString *)aString;

/// 圆角边框图片
+ (UIImage *)qh_imageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor image:(UIImage *)image;

@end


@interface UIImage (GQHGIF)

/// 播放GIF图片
+ (UIImage *)qh_animateGIFWithData:(NSData *)data;

@end
