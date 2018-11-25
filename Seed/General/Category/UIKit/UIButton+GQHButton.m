//
//  UIButton+GQHButton.m
//  Seed
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIButton+GQHButton.h"
#import <objc/message.h>


@implementation UIButton (GQHButton)

- (void)setQh_buttonGraphicLayoutStyle:(GQHButtonGraphicLayoutStyle)qh_buttonGraphicLayoutStyle {
    
    NSNumber *style = [NSNumber numberWithUnsignedInteger:qh_buttonGraphicLayoutStyle];
    objc_setAssociatedObject(self, @selector(qh_buttonGraphicLayoutStyle), style, OBJC_ASSOCIATION_ASSIGN);
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat imageWith = CGRectGetWidth(self.imageView.frame);
    CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
    
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    
    switch (qh_buttonGraphicLayoutStyle) {
            
        case GQHButtonGraphicLayoutStyleVerticalDefault: {
            
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - self.qh_buttonGraphicLayoutSpacing/2.0f, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - self.qh_buttonGraphicLayoutSpacing/2.0, 0);
        }
            break;
        case GQHButtonGraphicLayoutStyleVerticalOpposite: {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - self.qh_buttonGraphicLayoutSpacing/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - self.qh_buttonGraphicLayoutSpacing/2.0, -imageWith, 0, 0);
        }
            break;
        case GQHButtonGraphicLayoutStyleHorizontalDefault: {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, -self.qh_buttonGraphicLayoutSpacing/2.0, 0, self.qh_buttonGraphicLayoutSpacing/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, self.qh_buttonGraphicLayoutSpacing/2.0, 0, -self.qh_buttonGraphicLayoutSpacing/2.0);
        }
            break;
        case GQHButtonGraphicLayoutStyleHorizontalOpposite: {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + self.qh_buttonGraphicLayoutSpacing/2.0, 0, -labelWidth - self.qh_buttonGraphicLayoutSpacing/2.0);
            
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - self.qh_buttonGraphicLayoutSpacing/2.0, 0, imageWith + self.qh_buttonGraphicLayoutSpacing/2.0);
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = labelEdgeInsets;
}

- (GQHButtonGraphicLayoutStyle)qh_buttonGraphicLayoutStyle {
    
    NSNumber *style = objc_getAssociatedObject(self, _cmd);
    
    return [style unsignedIntegerValue];
}

- (void)setQh_buttonGraphicLayoutSpacing:(float)qh_buttonGraphicLayoutSpacing {
    
    NSNumber *spacing = [NSNumber numberWithFloat:qh_buttonGraphicLayoutSpacing];
    objc_setAssociatedObject(self, @selector(qh_buttonGraphicLayoutSpacing), spacing, OBJC_ASSOCIATION_ASSIGN);
}

- (float)qh_buttonGraphicLayoutSpacing {
    
    NSNumber *spacing = objc_getAssociatedObject(self, _cmd);
    
    return [spacing floatValue];
}

@end
