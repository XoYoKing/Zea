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


/**
 设置按钮图文排版样式

 @param qh_buttonGraphicLayoutStyle 按钮图文排版样式
 */
- (void)setQh_buttonGraphicLayoutStyle:(GQHButtonGraphicLayoutStyle)qh_buttonGraphicLayoutStyle {
    
    NSNumber *style = [NSNumber numberWithUnsignedInteger:qh_buttonGraphicLayoutStyle];
    objc_setAssociatedObject(self, @selector(qh_buttonGraphicLayoutStyle), style, OBJC_ASSOCIATION_ASSIGN);
    
    // 重布局按钮视图
    [self resetLayout];
}

/**
 获取按钮图文排版样式

 @return 按钮图文排版样式
 */
- (GQHButtonGraphicLayoutStyle)qh_buttonGraphicLayoutStyle {
    
    NSNumber *style = objc_getAssociatedObject(self, _cmd);
    
    switch ([style integerValue]) {
            
        case 1:
            return GQHButtonGraphicLayoutStyleVerticalOpposite;
            break;
        case 2:
            return GQHButtonGraphicLayoutStyleHorizontalDefault;
            break;
        case 3:
            return GQHButtonGraphicLayoutStyleHorizontalOpposite;
            break;
        default:
            return GQHButtonGraphicLayoutStyleVerticalDefault;
            break;
    }
}

/**
 设置按钮图文间距

 @param qh_buttonGraphicLayoutSpacing 按钮图文间距
 */
- (void)setQh_buttonGraphicLayoutSpacing:(float)qh_buttonGraphicLayoutSpacing {
    
    NSNumber *spacing = [NSNumber numberWithFloat:qh_buttonGraphicLayoutSpacing];
    objc_setAssociatedObject(self, @selector(qh_buttonGraphicLayoutSpacing), spacing, OBJC_ASSOCIATION_ASSIGN);
    
    // 重布局按钮视图
    [self resetLayout];
}

/**
 获取按钮图文间距

 @return 按钮图文间距
 */
- (float)qh_buttonGraphicLayoutSpacing {
    
    NSNumber *spacing = objc_getAssociatedObject(self, _cmd);
    
    return [spacing floatValue];
}

/**
 重布局按钮视图
 */
- (void)resetLayout {
    
    // 按钮图片宽度
    CGFloat imageWidth = self.currentImage.size.width;
    // 按钮图片高度
    CGFloat imageHeight = self.currentImage.size.height;

    // 按钮文本大小
    CGSize textSize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    // 按钮文本宽度
    CGFloat labelWidth = textSize.width;
    // 按钮文本高度
    CGFloat labelHeight = textSize.height;

    // image中心移动的x距离
    CGFloat imageOffsetX = 0.5f * (imageWidth + labelWidth) - 0.5f * imageWidth;
    // image中心移动的y距离
    CGFloat imageOffsetY = 0.5f * (imageHeight + self.qh_buttonGraphicLayoutSpacing);
    // label中心移动的x距离
    CGFloat labelOffsetX = (imageWidth + 0.5f * labelWidth) - 0.5f * (imageWidth + labelWidth);
    // label中心移动的y距离
    CGFloat labelOffsetY = 0.5f * (labelHeight + self.qh_buttonGraphicLayoutSpacing);

    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + self.qh_buttonGraphicLayoutSpacing - tempHeight;

    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets contentEdgeInsets = UIEdgeInsetsZero;

    switch (self.qh_buttonGraphicLayoutStyle) {

        case GQHButtonGraphicLayoutStyleVerticalDefault: {

            imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -0.5f * changedWidth, changedHeight - imageOffsetY, -0.5f * changedWidth);
        }
            break;
        case GQHButtonGraphicLayoutStyleVerticalOpposite: {

            imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            contentEdgeInsets = UIEdgeInsetsMake(changedHeight - imageOffsetY, -0.5f * changedWidth, imageOffsetY, -0.5f * changedWidth);
        }
            break;
        case GQHButtonGraphicLayoutStyleHorizontalDefault: {

            imageEdgeInsets = UIEdgeInsetsMake(0, -0.5f * self.qh_buttonGraphicLayoutSpacing, 0, 0.5f * self.qh_buttonGraphicLayoutSpacing);
            titleEdgeInsets = UIEdgeInsetsMake(0, 0.5f * self.qh_buttonGraphicLayoutSpacing, 0, -0.5f * self.qh_buttonGraphicLayoutSpacing);
            contentEdgeInsets = UIEdgeInsetsMake(0, 0.5f * self.qh_buttonGraphicLayoutSpacing, 0, 0.5f * self.qh_buttonGraphicLayoutSpacing);
        }
            break;
        case GQHButtonGraphicLayoutStyleHorizontalOpposite: {

            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + 0.5f * self.qh_buttonGraphicLayoutSpacing, 0, -labelWidth - 0.5f * self.qh_buttonGraphicLayoutSpacing);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth - 0.5f * self.qh_buttonGraphicLayoutSpacing, 0, imageWidth + 0.5f * self.qh_buttonGraphicLayoutSpacing);
            contentEdgeInsets = UIEdgeInsetsMake(0, 0.5f * self.qh_buttonGraphicLayoutSpacing, 0, 0.5f * self.qh_buttonGraphicLayoutSpacing);
        }
            break;
    }

    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
    self.contentEdgeInsets = contentEdgeInsets;
}

@end
