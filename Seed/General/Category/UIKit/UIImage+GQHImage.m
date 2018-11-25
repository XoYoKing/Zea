//
//  UIImage+GQHImage.m
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIImage+GQHImage.h"
#import <ImageIO/ImageIO.h>


@implementation UIImage (GQHImage)

// 纯色图片
+ (UIImage *)qh_imageWithColor:(UIColor *)color {
    
    return [self qh_imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)qh_imageWithColor:(UIColor *)color size:(CGSize)size {
    
    if (!color || size.width <= 0 || size.height <= 0) {
        
        return nil;
    }
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 灰度图片
- (UIImage *)qh_imageWithGrayscale {
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (!context){
        
        return nil;
    }
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), self.CGImage);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(context);
    CGImageRelease(imageRef);
    
    return image;
}

// 旋转图片
- (UIImage *)qh_imageRotatedWithDegrees:(CGFloat)degrees {
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    CGSize rotatedSize = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, 0.5f * rotatedSize.width, 0.5f * rotatedSize.height);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180.0f);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0f, 1.0f);
    CGContextDrawImage(bitmap, CGRectMake(-0.5f * rotatedSize.width, -0.5f * rotatedSize.height, rotatedSize.width, rotatedSize.height), self.CGImage);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 图片翻转
- (UIImage *)qh_imageFlipedWithDirection:(GQHFlipDirection)direction {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, CGImageGetWidth(self.CGImage), CGImageGetHeight(self.CGImage));
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    switch (direction) {
            
        case GQHFlipDirectionVertical: {
            
            transform = CGAffineTransformMakeTranslation(0.0f, CGRectGetHeight(rect));
            transform = CGAffineTransformScale(transform, 1.0f, -1.0f);
            
            CGContextScaleCTM(context, 1.0f, -1.0f);
            CGContextTranslateCTM(context, 0.0f, -CGRectGetHeight(rect));
        }
            break;
        case GQHFlipDirectionHorizontal: {
            
            transform = CGAffineTransformMakeTranslation(CGRectGetWidth(rect), 0.0f);
            transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
            
            CGContextScaleCTM(context, 1.0f, -1.0f);
            CGContextTranslateCTM(context, 0.0f, -CGRectGetHeight(rect));
        }
            break;
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, self.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 缩放图片指定尺寸
- (UIImage *)qh_imageRescaledWithSize:(CGSize)size {
    
    CGRect rect = (CGRect){CGPointZero,size};
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 截图/截屏
+ (UIImage *)qh_imageFromView:(__kindof UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, UIScreen.mainScreen.scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 添加图片水印
- (nonnull UIImage *)qh_watermarkImageWithRect:(CGRect)rect image:(nullable UIImage *)anImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [self drawAtPoint:CGPointZero];
    
    [anImage drawInRect:rect];
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return watermarkImage;
}

/// 添加文字水印
- (nonnull UIImage *)qh_watermarkImageWithRect:(CGRect)rect string:(nullable NSAttributedString *)aString {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [self drawAtPoint:CGPointZero];
    
    [aString drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return watermarkImage;
}

/// 圆角边框图片
+ (UIImage *)qh_imageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor image:(UIImage *)image {
    
    CGSize size = CGSizeMake(image.size.width + 2 * borderWidth, image.size.height + 2 * borderWidth);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    [path addClip];
    
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end


@implementation UIImage (GQHGIF)

// 播放GIF图片
+ (UIImage *)qh_animateGIFWithData:(NSData *)data {
    
    if (!data) {
        
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *gifImage;
    if (count <= 1) {
        
        gifImage = [[UIImage alloc] initWithData:data];
    } else {
        
        NSMutableArray *imageArray = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                
                continue;
            }
            
            duration += [self durationAtIndex:i source:source];
            [imageArray addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        
        if (!duration) {
            
            duration = (1.0f / 10.0f) * count;// ?
        }
        
        gifImage = [UIImage animatedImageWithImages:imageArray duration:duration];
    }
    CFRelease(source);
    
    return gifImage;
}

+ (float)durationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    
    float duration = 0.1f;
    
    CFDictionaryRef propertiesCF = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *properties = (__bridge NSDictionary *)propertiesCF;
    NSDictionary *gifProperties = properties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *unclampedDelayTime = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (unclampedDelayTime) {
        
        duration = [unclampedDelayTime floatValue];
    } else {
        
        NSNumber *delayTime = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTime) {
            
            duration = [delayTime floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible. We follow Firefox's behavior and use a duration of 100 ms for any frames that specify a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082> for more information.
    if (duration < 0.011f) {
        
        duration = 0.100f;
    }
    CFRelease(propertiesCF);
    
    return duration;
}

@end
