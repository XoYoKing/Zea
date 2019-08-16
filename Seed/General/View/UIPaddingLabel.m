//
//  UIPaddingLabel.m
//  Seed
//
//  Created by Mac on 2019/7/31.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "UIPaddingLabel.h"


@implementation UIPaddingLabel

/**
 计算内容实际大小

 @return 内容的实际大小
 */
- (CGSize)intrinsicContentSize {
    
    CGSize superContentSize = [super intrinsicContentSize];
    
    CGFloat width = superContentSize.width + self.leftPadding + self.rightPadding;
    CGFloat height = superContentSize.height + self.topPadding + self.bottomPadding;
    
    return CGSizeMake(width, height);
}

/**
 绘制文本

 @param rect 绘制区域
 */
- (void)drawTextInRect:(CGRect)rect {
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.padding)];
}

- (void)setPadding:(UIEdgeInsets)padding {
    
    self.topPadding = padding.top;
    self.bottomPadding = padding.bottom;
    
    self.leftPadding = padding.left;
    self.rightPadding = padding.right;
}

- (UIEdgeInsets)padding {
    
    return UIEdgeInsetsMake(self.topPadding, self.leftPadding, self.bottomPadding, self.rightPadding);
}

@end
