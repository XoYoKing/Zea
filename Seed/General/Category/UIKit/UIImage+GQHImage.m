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

/**
 将彩色图片转换成灰度图片
 
 @return 灰度图片
 */
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

/**
 旋转图片
 
 @param degrees 旋转角度
 @return 旋转后的图片
 */
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

/**
 翻转图片
 
 @param direction 翻转方向(水平翻转或垂向翻转)
 @return 翻转后的图片
 */
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

/**
 缩放图片到指定尺寸
 
 @param size 指定尺寸
 @return 指定尺寸的图片
 */
- (UIImage *)qh_imageRescaledWithSize:(CGSize)size {
    
    CGRect rect = (CGRect){CGPointZero,size};
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 添加图片水印
 
 @param rect 水印位置
 @param anImage 水印图片
 @return 带图片水印的图片
 */
- (nonnull UIImage *)qh_watermarkImageWithRect:(CGRect)rect image:(nullable UIImage *)anImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [self drawAtPoint:CGPointZero];
    
    [anImage drawInRect:rect];
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return watermarkImage;
}

/**
 添加文字水印
 
 @param rect 水印位置
 @param aString 水印文字
 @return 带文字水印的图片
 */
- (nonnull UIImage *)qh_watermarkImageWithRect:(CGRect)rect string:(nullable NSAttributedString *)aString {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [self drawAtPoint:CGPointZero];
    
    [aString drawWithRect:rect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    UIImage *watermarkImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return watermarkImage;
}


/**
 获取纯色图片
 
 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)qh_imageWithColor:(UIColor *)color {
    
    return [self qh_imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

/**
 获取指定大小的纯色图片
 
 @param color 颜色
 @param size 指定大小
 @return 指定大小的纯色图片
 */
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

/**
 截图/截屏
 
 @param view 源视图
 @return 截图/截屏
 */
+ (UIImage *)qh_imageFromView:(__kindof UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, UIScreen.mainScreen.scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 带边框的圆形图片
 
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param image 图片
 @return 带边框的圆形图片
 */
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

/**
 压缩图片到指定大小(质量和尺寸)

 @param image 图片
 @param maxValue 指定大小(单位KB)
 @return 图片数据
 */
+ (NSData *)qh_compressImage:(UIImage *)image toKilobytes:(NSUInteger)maxValue {
    
    // 首先压缩图片质量
    // 指定图片大小
    NSUInteger maxBytes = maxValue * 1000;
    NSUInteger minBytes = maxValue * 900;
    // 压缩系数
    CGFloat compression = 1.0f;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxBytes) return data;
    
    // 二分法搜索压缩系数
    CGFloat min = 0.0f;
    CGFloat max = 1.0f;
    for (NSInteger i = 0; i < 6; i++) {
        
        compression = (max + min) / 2.0f;
        data = UIImageJPEGRepresentation(image, compression);
        
        if (data.length < minBytes) {
            
            min = compression;
        } else if (data.length > maxBytes) {
            
            max = compression;
        } else {
            
            break;
        }
    }
    
    if (data.length < maxBytes) return data;
    
    // 如果压缩质量不满足要求，那么压缩图片尺寸
    UIImage *compressedImage = [UIImage imageWithData:data];
    NSUInteger lastBytes = 0;
    
    while (data.length > maxBytes && data.length != lastBytes) {
        
        lastBytes = data.length;
        
        CGFloat ratio = (CGFloat)maxBytes / data.length;
        // 尺寸使用整数防止出现白边
        CGSize size = CGSizeMake((NSUInteger)(compressedImage.size.width * sqrtf(ratio)), (NSUInteger)(compressedImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [compressedImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        compressedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(compressedImage, compression);
    }
    
    return data;
}

/**
 根据字符串生成二维码图片
 
 @param QRString 二维码图片字符串
 @param size 二维码图片大小
 @return 二维码图片
 */
+ (UIImage *)qh_QRImageFromString:(NSString *)QRString size:(CGFloat)size {
    
    return [self createNonInterpolatedUIImageFormCIImage:[self createQRFromString:QRString] withSize:size];
}

/**
 根据字符串生成二维码图片, 图片格式为CIImage
 
 @param QRString 二维码字符串
 @return 二维码图片(CIImage)
 */
+ (CIImage *)createQRFromString:(NSString *)QRString {
    
    NSData *stringData = [QRString dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *QRFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [QRFilter setValue:stringData forKey:@"inputMessage"];
    [QRFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    return QRFilter.outputImage;
}

/**
 将CIImage转换成可以控制大小的UIImage
 
 @param image 需要转换的图片(CIImage)
 @param size 二维码图片指定大小
 @return 图片(UIImage)
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

/**
 base64编码转图片
 
 @param encode base64编码
 @return 图片对象
 */
+ (UIImage *)qh_imageWithBase64:(NSString *)encode {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encode options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:data];
}

/**
 图片转base64编码
 
 @return base64编码
 */
- (NSString *)qh_base64 {
    
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end


@implementation UIImage (GQHGIF)

/**
 生成GIF图片
 
 @param data gif数据
 @return GIF图片
 */
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
