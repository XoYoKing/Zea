//
//  GQHImageCropManager.m
//  GQHKit
//
//  Created by GuanQinghao on 06/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHImageCropManager.h"
#import "UIView+GQHAnimation.h"
#import "GQHImageManager.h"
#import <ImageIO/ImageIO.h>

@implementation GQHImageCropManager

// 裁剪框蒙版
+ (void)qh_clippingMaskWithView:(UIView *)view clipRect:(CGRect)clipRect circular:(BOOL)isCircular {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    if (isCircular) {
        
        // 圆形裁剪框
        [path appendPath:[UIBezierPath bezierPathWithArcCenter:[UIApplication sharedApplication].keyWindow.center radius:0.5 * clipRect.size.width startAngle:0 endAngle:2 * M_PI clockwise:NO]];
    } else {
        
        // 矩形框
        [path appendPath:[UIBezierPath bezierPathWithRect:clipRect]];
    }
    
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.fillColor = [[UIColor blackColor] CGColor];
    layer.opacity = 0.5;
    [view.layer addSublayer:layer];
}

// 获得裁剪后的图片
+ (UIImage *)qh_clipImageView:(UIImageView *)imageView withContainerView:(UIView *)containerView rect:(CGRect)rect scale:(double)scale {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    // 平移处理
    CGRect imageViewRect = [imageView convertRect:imageView.bounds toView:containerView];
    CGPoint imageViewCenter = CGPointMake(imageViewRect.origin.x + 0.5 * imageViewRect.size.width, imageViewRect.origin.y + 0.5 * imageViewRect.size.height);
    
    CGFloat xMargin = containerView.frame.size.width - CGRectGetMaxX(rect) - rect.origin.x;
    CGPoint zerozPoint = CGPointMake(0.5 * (CGRectGetWidth(containerView.frame) - xMargin), containerView.center.y);
    CGPoint translation = CGPointMake(imageViewCenter.x - zerozPoint.x, imageViewCenter.y - zerozPoint.y);
    transform = CGAffineTransformTranslate(transform, translation.x, translation.y);
    
    // 缩放处理
    transform = CGAffineTransformScale(transform, scale, scale);
    
    CGImageRef imageRef = [self transformImageRef:imageView.image.CGImage withTransform:transform sourceSize:imageView.image.size outputWidth:(rect.size.width * [UIScreen mainScreen].scale) clipSize:rect.size imageViewSize:imageView.frame.size];
    
    UIImage *clippedImage = [UIImage imageWithCGImage:imageRef];
    clippedImage = [[GQHImageManager qh_manager] qh_fixOrientation:clippedImage];
    CGImageRelease(imageRef);
    
    return clippedImage;
}

// 位图转换
+ (CGImageRef)transformImageRef:(CGImageRef)imageRef withTransform:(CGAffineTransform)transform sourceSize: (CGSize)sourceSize outputWidth:(CGFloat)outputWidth clipSize:(CGSize)clipSize imageViewSize:(CGSize)imageViewSize {
    
    CGImageRef source = [self scaleImageRef:imageRef toSize:sourceSize];
    
    CGFloat aspect = clipSize.height / clipSize.width;
    CGSize outputSize = CGSizeMake(outputWidth, outputWidth * aspect);
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, outputSize.width, outputSize.height, CGImageGetBitsPerComponent(source), 0, CGImageGetColorSpace(source), CGImageGetBitmapInfo(source));
    CGContextSetFillColorWithColor(ctx, [[UIColor clearColor] CGColor]);
    CGContextFillRect(ctx, CGRectMake(0, 0, outputSize.width, outputSize.height));
    
    CGAffineTransform coordinate = CGAffineTransformMakeScale(outputSize.width / clipSize.width, outputSize.height / outputSize.height);
    coordinate = CGAffineTransformTranslate(coordinate, 0.5 * clipSize.width, 0.5 * clipSize.height);
    coordinate = CGAffineTransformScale(coordinate, 1.0, -1.0);
    CGContextConcatCTM(ctx, coordinate);
    
    CGContextConcatCTM(ctx, coordinate);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    
    CGContextDrawImage(ctx, CGRectMake(-0.5 * imageViewSize.width, -0.5 * imageViewSize.height, imageViewSize.width, imageViewSize.height), source);
    CGImageRef image = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    CGImageRelease(source);
    
    return image;
}

// 位图缩放
+ (CGImageRef)scaleImageRef:(CGImageRef)imageRef toSize:(CGSize)size {
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, rgbColorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(rgbColorSpace);
    
    CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
    CGContextTranslateCTM(ctx, 0.5 * size.width, 0.5 * size.height);
    
    CGContextDrawImage(ctx, CGRectMake(-0.5 * size.width, -0.5 * size.height, size.width, size.height), imageRef);
    CGImageRef scaledImageRef = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    
    return scaledImageRef;
}

// 获取裁剪后的圆形图片
+ (UIImage *)qh_clipRoundImage:(UIImage *)image {
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    
    [image drawInRect:rect];
    UIImage *roundImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return roundImage;
}

@end



