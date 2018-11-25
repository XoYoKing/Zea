//
//  UIButton+GQHButton.h
//  Seed
//
//  Created by Mac on 2018/7/5.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GQHButtonGraphicLayoutStyle) {
    
    /// 上图下字
    GQHButtonGraphicLayoutStyleVerticalDefault,
    /// 上字下图
    GQHButtonGraphicLayoutStyleVerticalOpposite,
    /// 左图右字
    GQHButtonGraphicLayoutStyleHorizontalDefault,
    /// 左字右图
    GQHButtonGraphicLayoutStyleHorizontalOpposite
};


@interface UIButton (GQHButton)

/// 按钮图文排版样式 (枚举)
@property (nonatomic, assign) GQHButtonGraphicLayoutStyle qh_buttonGraphicLayoutStyle;
/// 按钮图文间距 (需在设置样式 qh_buttonGraphicLayoutStyle 前设置)
@property (nonatomic, assign) float qh_buttonGraphicLayoutSpacing;

@end
