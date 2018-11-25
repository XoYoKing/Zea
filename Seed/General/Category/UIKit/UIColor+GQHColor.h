//
//  UIColor+GQHColor.h
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (GQHColor)

#pragma mark --PrimaryColor
/// 主色-红
+ (UIColor *)qh_appRedColor;
/// 主色-绿
+ (UIColor *)qh_appGreenColor;

#pragma mark --SecondaryColor
/// 辅色-黄
+ (UIColor *)qh_appYellowColor;
/// 辅色-橙色
+ (UIColor *)qh_appOrangeColor;
/// 辅色-粉色
+ (UIColor *)qh_appPinkColor;


#pragma mark --Constant
/// 字体颜色 灰色 (系统灰色)
@property (nonatomic, readonly, class) UIColor *qh_grayColor;
/// 字体颜色 深灰色
@property (nonatomic, readonly, class) UIColor *qh_darkGrayColor;
/// 字体颜色 深黑色
@property (nonatomic, readonly, class) UIColor *qh_darkBlackColor;

/// 浅灰色 背景色
@property (nonatomic, readonly, class) UIColor *qh_lightGrayColor;
/// 浅色 填充、描边、分隔等
@property (nonatomic, readonly, class) UIColor *qh_lightStrokeColor;
/// 深色 填充、描边、分隔等
@property (nonatomic, readonly, class) UIColor *qh_strokeColor;

/// 苹果蓝 (系统色)
@property (nonatomic, readonly, class) UIColor *qh_appleBlueColor;
/// 苹果导航颜色 (系统色)
@property (nonatomic, readonly, class) UIColor *qh_appleGrayColor;

#pragma mark --Converter
/// RGB
+ (UIColor *)qh_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
+ (UIColor *)qh_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

/// randomColor
+ (UIColor *)qh_colorWithRandomRGB;

/// HSB
+ (UIColor *)qh_colorWithHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness;
+ (UIColor *)qh_colorWithHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness alpha:(CGFloat)alpha;

/// Hex
+ (UIColor *)qh_colorWithHexString:(NSString *)hexString;
+ (UIColor *)qh_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)qh_colorWithHexValue:(uint32_t)hexValue;
+ (UIColor *)qh_colorWithHexValue:(uint32_t)hexValue alpha:(CGFloat)alpha;

/// 渐变色
+ (UIColor *)gradientColors:(NSArray *)CGColors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
