//
//  UIView+GQHBadge.m
//  Seed
//
//  Created by Mac on 2019/2/26.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "UIView+GQHBadge.h"
#import "CAAnimation+GQHAnimation.h"
#import <objc/message.h>


/// 默认红点大小
static CGFloat const kDotWidth = 8.0f;

@interface UIView ()

/**
 标识视图
 */
@property (nonatomic, strong) UILabel *badgeLabel;

/**
 标识样式
 */
@property (nonatomic, assign) GQHBadgeViewStyle badgeStyle;

@end

@implementation UIView (GQHBadge)

#pragma mark - GQHBadgeViewProtocol

/**
 显示标识, 默认为红点模式, 无动画
 */
- (void)qh_showBadgeView {
    
    [self qh_showBadgeViewWithStyle:GQHBadgeViewStyleRedDot animationType:GQHBadgeViewAnimationTypeNone];
}

/**
 显示标识
 
 @param style 消息标识视图样式
 @param animationType 消息标识视图动画样式
 */
- (void)qh_showBadgeViewWithStyle:(GQHBadgeViewStyle)style animationType:(GQHBadgeViewAnimationType)animationType {
    
    self.qh_badgeAnimationType = animationType;
    
    self.badgeStyle = style;
    
    switch (style) {
            
        case GQHBadgeViewStyleRedDot: {
            
            // 红点样式
            [self showDotBadgeView];
        }
            break;
        case GQHBadgeViewStyleCounter: {
            
            // 计数样式
            self.qh_badgeCount = 0;
            [self showCounterBadgeView:0];
        }
            break;
        case GQHBadgeViewStyleFixedText: {
            
            // 固定文本样式
            [self showFixedTextBadgeView];
        }
            break;
    }
    
    if (animationType != GQHBadgeViewAnimationTypeNone) {
        
        [self beginAnimation];
    }
}

/**
 移除标识
 */
- (void)qh_removeBadgeView {
    
    self.badgeLabel.hidden = YES;
}

#pragma mark - View
/**
 布局视图
 */
- (void)layoutUserInterface {
    
    if (!self.qh_badgeBackgroundColor) {
        
        self.qh_badgeBackgroundColor = UIColor.redColor;
    }
    
    if (!self.qh_badgeTextColor) {
        
        self.qh_badgeTextColor = UIColor.whiteColor;
    }
    
    if (!self.badgeLabel) {
        
        CGRect frame = CGRectMake(0.0f, 0.0f, kDotWidth, kDotWidth);
        self.badgeLabel = [[UILabel alloc] initWithFrame:frame];
        self.badgeLabel.center = CGPointMake(CGRectGetWidth(self.frame) + self.qh_badgeCenterOffset.x, self.qh_badgeCenterOffset.y);
        self.badgeLabel.text = @"";
        self.badgeLabel.textColor = self.qh_badgeTextColor;
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
        self.badgeLabel.backgroundColor = self.qh_badgeBackgroundColor;
        self.badgeStyle = GQHBadgeViewStyleRedDot;
        
        self.badgeLabel.layer.cornerRadius = 0.5f * fmin(CGRectGetWidth(self.badgeLabel.frame), CGRectGetHeight(self.badgeLabel.frame));
        self.badgeLabel.layer.masksToBounds = YES;
        self.badgeLabel.hidden = NO;
        
        [self addSubview:self.badgeLabel];
        [self bringSubviewToFront:self.badgeLabel];
    }
}

#pragma mark - PrivateMethod
/**
 红点样式
 */
- (void)showDotBadgeView {
    
    [self layoutUserInterface];
    
    self.badgeLabel.text = @"";
    self.badgeStyle = GQHBadgeViewStyleRedDot;
    
    self.badgeLabel.frame = CGRectMake(0.0f, 0.0f, kDotWidth, kDotWidth);
    self.badgeLabel.center = CGPointMake(CGRectGetWidth(self.frame) + self.qh_badgeCenterOffset.x, self.qh_badgeCenterOffset.y);
    self.badgeLabel.layer.cornerRadius = 0.5f * CGRectGetWidth(self.badgeLabel.frame);
    self.badgeLabel.hidden = NO;
}

/**
 计数样式

 @param count 消息计数
 */
- (void)showCounterBadgeView:(NSInteger)count {
    
    if (count < 0) {
        
        return;
    }
    
    [self layoutUserInterface];
    
    self.badgeLabel.hidden = !count;
    self.badgeStyle = GQHBadgeViewStyleCounter;
    
    self.badgeLabel.font = self.qh_badgeFont;
    self.badgeLabel.text = (count > self.qh_badgeMaxNumber) ? [NSString stringWithFormat:@"%@+", @(self.qh_badgeMaxNumber)] : [NSString stringWithFormat:@"%@", @(count)];
    [self layoutBadgeView:self.badgeLabel];
}

/**
 固定文字样式
 */
- (void)showFixedTextBadgeView {
    
    [self layoutUserInterface];
    
    self.badgeLabel.hidden = NO;
    
    if (self.qh_badgeFixedText && self.qh_badgeFixedText.length > 0) {
        
        self.badgeLabel.text = self.qh_badgeFixedText;
    } else {
        
        self.badgeLabel.text = @"new";
    }
    
    self.badgeLabel.font = self.qh_badgeFont;
    self.badgeStyle = GQHBadgeViewStyleFixedText;
    [self layoutBadgeView:self.badgeLabel];
}

/**
 重布局标识视图

 @param badgeLabel 消息标识视图
 */
- (void)layoutBadgeView:(UILabel *)badgeLabel {
    
    badgeLabel.numberOfLines = 0;
    NSString *text = badgeLabel.text;
    UIFont *font = badgeLabel.font;
    CGSize size;
    
    NSMutableParagraphStyle *style = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
    style.lineBreakMode = NSLineBreakByCharWrapping;
    
    size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : style} context:nil].size;
    
    
    CGRect frame = badgeLabel.frame;
    frame.size = CGSizeMake(ceilf(size.width) + 6.0f, ceilf(size.height) + 6.0f);
    if (CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        
        frame.size.width = CGRectGetHeight(frame);
    }
    
    badgeLabel.frame = frame;
    badgeLabel.center = CGPointMake(self.qh_badgeCenterOffset.x, self.qh_badgeCenterOffset.y);
    badgeLabel.layer.cornerRadius = 0.5f * CGRectGetHeight(self.badgeLabel.frame);
}

/**
 开始动画
 */
- (void)beginAnimation {
    
    switch (self.qh_badgeAnimationType) {
            
        case GQHBadgeViewAnimationTypeNone: {
            
            
        }
            break;
        case GQHBadgeViewAnimationTypeScaled: {
            
            [self.badgeLabel.layer addAnimation:[CAAnimation qh_scaleAnimationWithScaleFrom:1.2f to:0.6f repeat:MAXFLOAT duration:1.0f] forKey:@"scale"];
        }
            break;
        case GQHBadgeViewAnimationTypeShaked: {
            
            [self.badgeLabel.layer addAnimation:[CAAnimation qh_shakeAnimationWithLayer:self.badgeLabel.layer repeat:MAXFLOAT duration:1.0f] forKey:@"shake"];
        }
            break;
        case GQHBadgeViewAnimationTypeBouncing: {
            
            [self.badgeLabel.layer addAnimation:[CAAnimation qh_bounceAnimationWithLayer:self.badgeLabel.layer repeat:MAXFLOAT duration:1.0f] forKey:@"bounce"];
        }
            break;
        case GQHBadgeViewAnimationTypeBreathing: {
            
            [self.badgeLabel.layer addAnimation:[CAAnimation qh_breatheAnimationWithRepeat:MAXFLOAT duration:1.0f] forKey:@"breathe"];
        }
            break;
    }
}

/**
 移除动画
 */
- (void)removeAnimation {
    
    if (self.badgeLabel) {
        
        [self.badgeLabel.layer removeAllAnimations];
    }
}

#pragma mark - Setter/Getter
/// 标识视图
- (void)setBadgeLabel:(UILabel *)badgeLabel {
    
    objc_setAssociatedObject(self, @selector(badgeLabel), badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)badgeLabel {
    
    return objc_getAssociatedObject(self, _cmd);
}

/// 标识字体
- (void)setQh_badgeFont:(UIFont *)qh_badgeFont {
    
    objc_setAssociatedObject(self, @selector(qh_badgeFont), qh_badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badgeLabel.font = qh_badgeFont;
    [self layoutBadgeView:self.badgeLabel];
}

- (UIFont *)qh_badgeFont {
    
    UIFont *font = objc_getAssociatedObject(self, _cmd);
    
    return font ? : ([UIFont boldSystemFontOfSize:9.0f]);
}

/// 标识视图背景颜色
- (void)setQh_badgeBackgroundColor:(UIColor *)qh_badgeBackgroundColor {
    
    objc_setAssociatedObject(self, @selector(qh_badgeBackgroundColor), qh_badgeBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badgeLabel.backgroundColor = qh_badgeBackgroundColor;
}

- (UIColor *)qh_badgeBackgroundColor {
    
    return objc_getAssociatedObject(self, _cmd);
}

/// 标识文字颜色
- (void)setQh_badgeTextColor:(UIColor *)qh_badgeTextColor {
    
    objc_setAssociatedObject(self, @selector(qh_badgeTextColor), qh_badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badgeLabel.textColor = qh_badgeTextColor;
}

- (UIColor *)qh_badgeTextColor {
    
    return objc_getAssociatedObject(self, _cmd);
}

/// 标识视图中心点偏移量
- (void)setQh_badgeCenterOffset:(CGPoint)qh_badgeCenterOffset {
    
    NSDictionary *center = @{
                             @"x" : @(qh_badgeCenterOffset.x),
                             @"y" : @(qh_badgeCenterOffset.y)
                             };
    
    objc_setAssociatedObject(self, @selector(qh_badgeCenterOffset), center, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badgeLabel.center = CGPointMake(qh_badgeCenterOffset.x, qh_badgeCenterOffset.y);
}

- (CGPoint)qh_badgeCenterOffset {
    
    NSDictionary *object = objc_getAssociatedObject(self, _cmd);
    
    if (object && 2 == [object count]) {
        
        CGFloat x = [[object objectForKey:@"x"] floatValue];
        CGFloat y = [[object objectForKey:@"y"] floatValue];
        
        return CGPointMake(x, y);
    } else {
        
        return CGPointZero;
    }
}

/// 标识显示的数目
- (void)setQh_badgeCount:(NSInteger)qh_badgeCount {
    
    NSNumber *count = @(qh_badgeCount);
    
    objc_setAssociatedObject(self, @selector(qh_badgeCount), count, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.badgeStyle == GQHBadgeViewStyleCounter) {
        
        [self showCounterBadgeView:self.qh_badgeCount];
    }
}

- (NSInteger)qh_badgeCount {
    
    NSNumber *object = objc_getAssociatedObject(self, _cmd);
    
    if (object) {
        
        return [object integerValue];
    } else {
        
        return 0;
    }
}

/// 标识显示的固定文本
- (void)setQh_badgeFixedText:(NSString *)qh_badgeFixedText {
    
    objc_setAssociatedObject(self, @selector(qh_badgeFixedText), qh_badgeFixedText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (qh_badgeFixedText && qh_badgeFixedText.length > 0 && self.badgeStyle == GQHBadgeViewStyleFixedText) {
        
        self.badgeLabel.text = qh_badgeFixedText;
        [self layoutBadgeView:self.badgeLabel];
    }
}

- (NSString *)qh_badgeFixedText {
    
    return objc_getAssociatedObject(self, _cmd);
}

/// 标识显示的最大数目, 默认99
- (void)setQh_badgeMaxNumber:(NSInteger)qh_badgeMaxNumber {
    
    NSNumber *max = @(qh_badgeMaxNumber);
    
    objc_setAssociatedObject(self, @selector(qh_badgeMaxNumber), max, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.badgeStyle == GQHBadgeViewStyleCounter) {
        
        [self showCounterBadgeView:self.qh_badgeCount];
    }
}

- (NSInteger)qh_badgeMaxNumber {
    
    NSNumber *object = objc_getAssociatedObject(self, _cmd);
    
    if (object) {
        
        return [object integerValue];
    } else {
        
        return 99;
    }
}

/// 标识样式
- (void)setBadgeStyle:(GQHBadgeViewStyle)badgeStyle {
    
    objc_setAssociatedObject(self, @selector(badgeStyle), @(badgeStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (GQHBadgeViewStyle)badgeStyle {
    
    NSNumber *style = objc_getAssociatedObject(self, _cmd);
    switch ([style integerValue]) {
            
        case 1:
            return GQHBadgeViewStyleCounter;
            break;
        case 2:
            return GQHBadgeViewStyleFixedText;
            break;
        default:
            return GQHBadgeViewStyleRedDot;
            break;
    }
}

/// 标识动画样式
- (void)setQh_badgeAnimationType:(GQHBadgeViewAnimationType)qh_badgeAnimationType {
    
    objc_setAssociatedObject(self, @selector(qh_badgeAnimationType), @(qh_badgeAnimationType), OBJC_ASSOCIATION_ASSIGN);
    
    [self removeAnimation];
    [self beginAnimation];
}

- (GQHBadgeViewAnimationType)qh_badgeAnimationType {
    
    NSNumber *type = objc_getAssociatedObject(self, _cmd);
    
    switch ([type integerValue]) {
            
        case 1:
            return GQHBadgeViewAnimationTypeShaked;
            break;
        case 2:
            return GQHBadgeViewAnimationTypeBouncing;
            break;
        case 3:
            return GQHBadgeViewAnimationTypeScaled;
            break;
        case 4:
            return GQHBadgeViewAnimationTypeBreathing;
            break;
        default:
            return GQHBadgeViewAnimationTypeNone;
            break;
    }
}

@end
