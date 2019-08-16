//
//  UIDashLineView.m
//  Seed
//
//  Created by Mac on 2019/7/31.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "UIDashLineView.h"

@implementation UIDashLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 内容上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置线的顶端样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 设置线的相交模式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    // 设置线的宽度
    CGContextSetLineWidth(context, self.dashLineWidth);
    // 设置线的颜色
    CGContextSetStrokeColorWithColor(context, self.dashLineColor.CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    
#warning to-do
    // 虚线样式
    CGFloat lengths[] = {5,5};
    NSInteger count = sizeof(lengths) / sizeof(CGFloat);
    // 虚线样式和样式起点
    CGContextSetLineDash(context, 0, lengths, count);
    
    
//    memcpy(_points, points, sizeof(BMKMapPoint) * count);
    
//    NSInteger count = sizeof(self.lengths);
    
    // 虚线样式和样式起点
//    CGContextSetLineDash(context, 0, self.lengths, count);
//
//    NSLog(@"%@-%@",@(self.lengths[0]),@(self.lengths[1]));
//
    
//    CGFloat *lengths = (__bridge_retained CGFloat *)(self.lengths);
//
//    CGContextSetLineDash(context, 0, lengths, count);
    
    
    // 虚线所有拐点
    [self.dashLines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSValue *pointValue = (NSValue *)obj;
        
        if (0 == idx) {
            
            CGPoint point = [pointValue CGPointValue];
            // 虚线起点
            CGContextMoveToPoint(context, point.x, point.y);
        } else {
            
            CGPoint point = [pointValue CGPointValue];
            // 虚线折点
            CGContextAddLineToPoint(context, point.x, point.y);
        }
    }];
    
    // 绘制
    CGContextStrokePath(context);
    // 关闭图像
    CGContextClosePath(context);
}

- (void)setDashLines:(NSArray *)dashLines {
    
    _dashLines = dashLines;
    
    [self setNeedsDisplay];
}

@end
