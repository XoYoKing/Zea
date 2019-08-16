//
//  UIBarButtonItem+GQHBadge.m
//  Seed
//
//  Created by Mac on 2019/2/27.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "UIBarButtonItem+GQHBadge.h"
#import "UIView+GQHBadge.h"
#import <objc/runtime.h>


@implementation UIBarButtonItem (GQHBadge)

#pragma mark - GQHBadgeViewProtocol
/**
 显示标识, 默认为红点模式, 无动画
 */
- (void)qh_showBadgeView {
    
    [[self getBadgeSuperView] qh_showBadgeView];
}

/**
 显示标识
 
 @param style 消息标识视图样式
 @param animationType 消息标识视图动画样式
 */
- (void)qh_showBadgeViewWithStyle:(GQHBadgeViewStyle)style animationType:(GQHBadgeViewAnimationType)animationType {
    
    [[self getBadgeSuperView] qh_showBadgeViewWithStyle:style animationType:animationType];
}

/**
 移除标识
 */
- (void)qh_removeBadgeView {
    
    [[self getBadgeSuperView] qh_removeBadgeView];
}

#pragma mark - PrivateMethod
/**
 获取父视图

 @return 父视图
 */
- (UIView *)getBadgeSuperView {
    
    return [self valueForKeyPath:@"_view"];
}

#pragma mark - Setter/Getter
/// 标识字体
- (void)setQh_badgeFont:(UIFont *)qh_badgeFont {
    
    [self getBadgeSuperView].qh_badgeFont = qh_badgeFont;
}

- (UIFont *)qh_badgeFont {
    
    return [self getBadgeSuperView].qh_badgeFont;
}

/// 标识视图背景颜色
- (void)setQh_badgeBackgroundColor:(UIColor *)qh_badgeBackgroundColor {
    
    [self getBadgeSuperView].qh_badgeBackgroundColor = qh_badgeBackgroundColor;
}

- (UIColor *)qh_badgeBackgroundColor {
    
    return [self getBadgeSuperView].qh_badgeBackgroundColor;
}

/// 标识文字颜色
- (void)setQh_badgeTextColor:(UIColor *)qh_badgeTextColor {
    
    [self getBadgeSuperView].qh_badgeTextColor = qh_badgeTextColor;
}

- (UIColor *)qh_badgeTextColor {
    
    return [self getBadgeSuperView].qh_badgeTextColor;
}

/// 标识视图中心点偏移量
- (void)setQh_badgeCenterOffset:(CGPoint)qh_badgeCenterOffset {
    
    [self getBadgeSuperView].qh_badgeCenterOffset = qh_badgeCenterOffset;
}

- (CGPoint)qh_badgeCenterOffset {
    
    return [self getBadgeSuperView].qh_badgeCenterOffset;
}

/// 标识显示的数目
- (void)setQh_badgeCount:(NSInteger)qh_badgeCount {
    
    [self getBadgeSuperView].qh_badgeCount = qh_badgeCount;
}

- (NSInteger)qh_badgeCount {
    
    return [self getBadgeSuperView].qh_badgeCount;
}

/// 标识显示的固定文本
- (void)setQh_badgeFixedText:(NSString *)qh_badgeFixedText {
    
    [self getBadgeSuperView].qh_badgeFixedText = qh_badgeFixedText;
}

- (NSString *)qh_badgeFixedText {
    
    return [self getBadgeSuperView].qh_badgeFixedText;
}

/// 标识显示的最大数目, 默认99
- (void)setQh_badgeMaxNumber:(NSInteger)qh_badgeMaxNumber {
    
    [self getBadgeSuperView].qh_badgeMaxNumber = qh_badgeMaxNumber;
}

- (NSInteger)qh_badgeMaxNumber {
    
    return [self getBadgeSuperView].qh_badgeMaxNumber;
}

/// 标识动画样式
- (void)setQh_badgeAnimationType:(GQHBadgeViewAnimationType)qh_badgeAnimationType {
    
    [self getBadgeSuperView].qh_badgeAnimationType = qh_badgeAnimationType;
}

- (GQHBadgeViewAnimationType)qh_badgeAnimationType {
    
    return [self getBadgeSuperView].qh_badgeAnimationType;
}

@end
