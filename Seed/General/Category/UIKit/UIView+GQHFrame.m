//
//  UIView+GQHFrame.m
//  Seed
//
//  Created by GuanQinghao on 12/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIView+GQHFrame.h"


CGFloat const GQHFrameSingleMargin = 16.0f;
CGFloat const GQHFrameDoubleMargin = 2 * GQHFrameSingleMargin;


@implementation UIView (GQHFrame)

#pragma mark Setter/Getter
// qh_x
- (void)setQh_x:(CGFloat)qh_x {
    
    CGRect rect = self.frame;
    rect.origin.x = qh_x;
    self.frame = rect;
}

- (CGFloat)qh_x {
    
    return CGRectGetMinX(self.frame);
}

// qh_y
- (void)setQh_y:(CGFloat)qh_y {
    
    CGRect rect = self.frame;
    rect.origin.y = qh_y;
    self.frame = rect;
}

- (CGFloat)qh_y {
    
    return CGRectGetMinY(self.frame);
}

// qh_width
- (void)setQh_width:(CGFloat)qh_width {
    
    CGRect rect = self.frame;
    rect.size.width = qh_width;
    self.frame = rect;
}

- (CGFloat)qh_width {
    
    return CGRectGetWidth(self.frame);
}

// qh_height
- (void)setQh_height:(CGFloat)qh_height {
    
    CGRect rect = self.frame;
    rect.size.height = qh_height;
    self.frame = rect;
}

- (CGFloat)qh_height {
    
    return CGRectGetHeight(self.frame);
}

// qh_left
- (void)setQh_left:(CGFloat)qh_left {
    
    CGRect rect = self.frame;
    rect.origin.x = qh_left;
    self.frame = rect;
}

- (CGFloat)qh_left {
    
    return CGRectGetMinX(self.frame);
}

// qh_right
- (void)setQh_right:(CGFloat)qh_right {
    
    CGRect rect = self.frame;
    rect.size.width = qh_right - rect.origin.x;
    self.frame = rect;
}

- (CGFloat)qh_right {
    
    return CGRectGetMaxX(self.frame);
}

// qh_top
- (void)setQh_top:(CGFloat)qh_top {
    
    CGRect rect = self.frame;
    rect.origin.y = qh_top;
    self.frame = rect;
}

- (CGFloat)qh_top {
    
    return CGRectGetMinY(self.frame);
}

// qh_bottom
- (void)setQh_bottom:(CGFloat)qh_bottom {
    
    CGRect rect = self.frame;
    rect.size.height = qh_bottom - rect.origin.y;
    self.frame = rect;
}

- (CGFloat)qh_bottom {
    
    return CGRectGetMaxY(self.frame);
}

// qh_alignLeft
- (void)setQh_alignLeft:(CGFloat)qh_alignLeft {
    
    [self setQh_left:qh_alignLeft];
}

- (CGFloat)qh_alignLeft {
    
    return [self qh_left];
}

// qh_alignRight
- (void)setQh_alignRight:(CGFloat)qh_alignRight {
    
    CGRect rect = self.frame;
    rect.origin.x = qh_alignRight - rect.size.width;
    self.frame = rect;
}

- (CGFloat)qh_alignRight {
    
    return [self qh_right];
}

// qh_alignTop
- (void)setQh_alignTop:(CGFloat)qh_alignTop {
    
    [self setQh_top:qh_alignTop];
}

- (CGFloat)qh_alignTop {
    
    return [self qh_top];
}

// qh_alignBottom
- (void)setQh_alignBottom:(CGFloat)qh_alignBottom {
    
    CGRect rect = self.frame;
    rect.origin.y = qh_alignBottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)qh_alignBottom {
    
    return [self qh_bottom];
}

// qh_centerX
- (void)setQh_centerX:(CGFloat)qh_centerX {
    
    self.center = CGPointMake(qh_centerX, self.center.y);
}

- (CGFloat)qh_centerX {
    
    return self.center.x;
}

// qh_centerY
- (void)setQh_centerY:(CGFloat)qh_centerY {
    
    self.center = CGPointMake(self.center.x, qh_centerY);
}

- (CGFloat)qh_centerY {
    
    return self.center.y;
}

// qh_originPoint
- (void)setQh_originPoint:(CGPoint)qh_originPoint {
    
    CGRect rect = self.frame;
    rect.origin = qh_originPoint;
    self.frame = rect;
}

- (CGPoint)qh_originPoint {
    
    return self.frame.origin;
}

// qh_size
- (void)setQh_size:(CGSize)qh_size {
    
    CGRect rect = self.frame;
    rect.size = qh_size;
    self.frame = rect;
}

- (CGSize)qh_size {
    
    return self.frame.size;
}

// qh_resizeCenter
- (void)setQh_resizeCenter:(CGSize)qh_resizeCenter {
    
    CGPoint center = self.center;
    
    CGRect rect = self.frame;
    rect.size = qh_resizeCenter;
    self.frame = rect;
    
    self.center = center;
}

- (CGSize)qh_resizeCenter {
    
    return self.qh_size;
}

// qh_resizeTop
- (void)setQh_resizeTop:(CGSize)qh_resizeTop {
    
    CGFloat x = self.qh_x + 0.5 * (self.qh_width - qh_resizeTop.width);
    CGFloat y = self.qh_y;
    CGPoint origin = CGPointMake(x, y);
    
    CGRect rect = self.frame;
    rect.size = qh_resizeTop;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeTop {
    
    return self.qh_size;
}

// qh_resizeBottom
- (void)setQh_resizeBottom:(CGSize)qh_resizeBottom {
    
    CGFloat x = self.qh_x + 0.5 * (self.qh_width - qh_resizeBottom.width);
    CGFloat y = self.qh_y + (self.qh_height - qh_resizeBottom.height);
    CGPoint origin = CGPointMake(x, y);
    
    CGRect rect = self.frame;
    rect.size = qh_resizeBottom;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeBottom {
    
    return self.qh_size;
}

// qh_resizeLeft
- (void)setQh_resizeLeft:(CGSize)qh_resizeLeft {
    
    CGFloat x = self.qh_x;
    CGFloat y = self.qh_y + 0.5 * (self.qh_height - qh_resizeLeft.height);
    CGPoint origin = CGPointMake(x, y);
    
    CGRect rect = self.frame;
    rect.size = qh_resizeLeft;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeLeft {
    
    return self.qh_size;
}

// qh_resizeRight
- (void)setQh_resizeRight:(CGSize)qh_resizeRight {
    
    CGFloat x = self.qh_x + (self.qh_width - qh_resizeRight.width);
    CGFloat y = self.qh_y + 0.5 * (self.qh_height - qh_resizeRight.height);
    CGPoint origin = CGPointMake(x, y);
    
    CGRect rect = self.frame;
    rect.size = qh_resizeRight;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeRight {
    
    return self.qh_size;
}

// qh_resizeTopLeft
- (void)setQh_resizeTopLeft:(CGSize)qh_resizeTopLeft {
    
    CGPoint origin = self.frame.origin;
    
    CGRect rect = self.frame;
    rect.size = qh_resizeTopLeft;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeTopLeft {
    
    return self.qh_size;
}

// qh_resizeTopRight
- (void)setQh_resizeTopRight:(CGSize)qh_resizeTopRight {
    
    CGFloat x = self.qh_x + (self.qh_width - qh_resizeTopRight.width);
    CGFloat y = self.qh_y;
    CGPoint origin = CGPointMake(x, y);
    
    CGRect rect = self.frame;
    rect.size = qh_resizeTopRight;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeTopRight {
    
    return self.qh_size;
}

// qh_resizeBottomLeft
- (void)setQh_resizeBottomLeft:(CGSize)qh_resizeBottomLeft {
    
    CGFloat x = self.qh_x;
    CGFloat y = self.qh_y + (self.qh_height - qh_resizeBottomLeft.height);
    CGPoint origin = CGPointMake(x, y);
    
    CGRect rect = self.frame;
    rect.size = qh_resizeBottomLeft;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeBottomLeft {
    
    return self.qh_size;
}

// qh_resizeBottomRight
- (void)setQh_resizeBottomRight:(CGSize)qh_resizeBottomRight {
    
    CGFloat x = self.qh_x + (self.qh_width - qh_resizeBottomRight.width);
    CGFloat y = self.qh_y + (self.qh_height - qh_resizeBottomRight.height);
    CGPoint origin = CGPointMake(x, y);
    
    CGRect rect = self.frame;
    rect.size = qh_resizeBottomRight;
    self.frame = rect;
    
    self.qh_originPoint = origin;
}

- (CGSize)qh_resizeBottomRight {
    
    return self.qh_size;
}

// qh_contentAreaWidth
- (CGFloat)qh_contentAreaWidth {
    
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

// qh_contentAreaHeight
- (CGFloat)qh_contentAreaHeight {
    
    return CGRectGetHeight([UIScreen mainScreen].bounds) - [self qh_statusBarHeight] - [self qh_navigationBarHeight] - [self qh_tabBarHeight] - [self qh_homeIndicatorHeight];
}

// qh_safeAreaWidth
- (CGFloat)qh_safeAreaWidth {
    
    return CGRectGetWidth([UIScreen mainScreen].bounds);
}

// qh_safeAreaHeight
- (CGFloat)qh_safeAreaHeight {
    
    return CGRectGetHeight([UIScreen mainScreen].bounds) - [self qh_statusBarHeight] - [self qh_homeIndicatorHeight];
}

// qh_statusBarHeight
- (CGFloat)qh_statusBarHeight {
    
    if (812.0f == CGRectGetHeight([UIScreen mainScreen].bounds) || 896.0f == CGRectGetHeight([UIScreen mainScreen].bounds)) {
        
        return 44.0f;
    }
    
    return 20.0f;
}

// qh_navigationBarHeight
- (CGFloat)qh_navigationBarHeight {
    
    return 44.0f;
}

// qh_tabBarHeight
- (CGFloat)qh_tabBarHeight {
    
    return 49.0f;
}

// qh_homeIndicatorHeight
- (CGFloat)qh_homeIndicatorHeight {
    
    if (812.0f == CGRectGetHeight([UIScreen mainScreen].bounds) || 896.0f == CGRectGetHeight([UIScreen mainScreen].bounds)) {
        
        return 34.0f;
    }
    
    return 0.0f;
}

// 切圆角
- (void)qh_cornerWithRaius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

#pragma mark --视图继承关系
// 移除所有子视图
- (void)qh_removeAllSubviews {
    
    while (self.subviews.count) {
        
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end

#pragma mark 视图控制器
@implementation UIView (GQHController)

/// 视图控制器
- (UIViewController *)qh_currentViewController {
    
    UIResponder *next = [self nextResponder];
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

/// 视图导航控制器
- (UINavigationController *)qh_navigationController {
    
    return [self qh_currentViewController].navigationController;
}

@end
