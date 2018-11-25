//
//  UIColor+GQHColor.m
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIColor+GQHColor.h"


@implementation UIColor (GQHColor)

#pragma mark --PrimaryColor
+ (UIColor *)qh_appRedColor {
    
    return [UIColor colorWithRed:212/255.0f green:23/255.0f blue:3/255.0f alpha:1.0f];
}

+ (UIColor *)qh_appGreenColor {
    
    return [UIColor colorWithRed:37/255.0f green:182/255.0f blue:114/255.0f alpha:1.0f];
}

#pragma mark --SecondaryColor
+ (UIColor *)qh_appYellowColor {
    
    return [UIColor colorWithRed:248/255.0f green:191/255.0f blue:18/255.0f alpha:1.0f];
}

+ (UIColor *)qh_appOrangeColor {
    
    return [UIColor colorWithRed:250/255.0f green:142/255.0f blue:1/255.0f alpha:1.0f];
}

+ (UIColor *)qh_appPinkColor {
    
    return [UIColor colorWithRed:253/255.0f green:85/255.0f blue:85/255.0f alpha:1.0f];
}


#pragma mark --Constant
+ (UIColor *)qh_grayColor {
    
    return [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
}

+ (UIColor *)qh_darkGrayColor {
    
    return [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
}

+ (UIColor *)qh_darkBlackColor {
    
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
}

+ (UIColor *)qh_lightGrayColor {
    
    return [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
}

+ (UIColor *)qh_lightStrokeColor {
    
    return [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
}

+ (UIColor *)qh_strokeColor {
    
    return [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
}

+ (UIColor *)qh_appleBlueColor {
    
    return [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0];
}

+ (UIColor *)qh_appleGrayColor {
    
    return [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
}

#pragma mark --Converter
// RGB
+ (UIColor *)qh_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    
    return [self qh_colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)qh_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha {
    
    alpha = (alpha < 0.0) ? 0.0 : ((alpha > 1.0) ? 1.0 : alpha);
    
    if (red < 256 && green < 256 && red < 256) {
        
        return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/1.0f];
    } else {
        
        return [UIColor clearColor];
    }
}

// randomColor
+ (UIColor *)qh_colorWithRandomRGB {
    
    NSUInteger red = arc4random()%256;
    NSUInteger green = arc4random()%256;
    NSUInteger blue = arc4random()%256;
    
    return [self qh_colorWithRed:red green:green blue:blue];
}

// HSB
+ (UIColor *)qh_colorWithHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness {
    
    return [self qh_colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0f];
}

+ (UIColor *)qh_colorWithHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness alpha:(CGFloat)alpha {
    
    alpha = (alpha < 0.0) ? 0.0 : ((alpha > 1.0) ? 1.0 : alpha);
    
    hue = (hue > 360) ? 360 : hue;
    saturation = (saturation > 100) ? 100 : saturation;
    brightness = (brightness > 100) ? 100 : brightness;
    
    return [UIColor colorWithHue:hue/360.0f saturation:saturation/100.0f brightness:brightness/100.0f alpha:alpha/1.0f];
}

// Hex
+ (UIColor *)qh_colorWithHexString:(NSString *)hexString {
    
    return [self qh_colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)qh_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6 || [cString length] > 8) {
        
        return [UIColor clearColor];
    }
    
    if ([cString hasPrefix:@"0X"]) {
        
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString hasPrefix:@"#"]) {
        
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        
        return [UIColor clearColor];
    }
    
    NSRange range = NSMakeRange(0, 2);
    NSString *redString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *greenString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *blueString = [cString substringWithRange:range];
    
    unsigned int red;
    unsigned int green;
    unsigned int blue;
    
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
    return [self qh_colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)qh_colorWithHexValue:(uint32_t)hexValue {
    
    return [self qh_colorWithHexValue:hexValue alpha:1.0f];
}

+ (UIColor *)qh_colorWithHexValue:(uint32_t)hexValue alpha:(CGFloat)alpha {
    
    int red = (hexValue & 0xFF0000) >> 16;
    int green = (hexValue & 0xFF00) >> 8;
    int blue = (hexValue & 0xFF) >> 0;
    
    return [self qh_colorWithRed:red green:green blue:blue alpha:alpha];
}

// 渐变色
+ (UIColor *)gradientColors:(NSArray *)CGColors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    double width =  fabs(endPoint.x - startPoint.x);
    double height = fabs(endPoint.y - startPoint.y);
    
    width = width ? : 1.0;
    height = height ? : 1.0;
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)CGColors, NULL);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:image];
}

@end
