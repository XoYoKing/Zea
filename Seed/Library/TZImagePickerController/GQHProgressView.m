//
//  GQHProgressView.m
//  GQHKit
//
//  Created by GuanQinghao on 31/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHProgressView.h"

@interface GQHProgressView ()

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end


@implementation GQHProgressView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [[UIColor clearColor] CGColor];
        _progressLayer.strokeColor = [[UIColor whiteColor] CGColor];
        _progressLayer.opacity = 1;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = 5;
        
        _progressLayer.shadowColor = [[UIColor blackColor] CGColor];
        _progressLayer.shadowOffset = CGSizeMake(1, 1);
        _progressLayer.shadowOpacity = 0.5;
        _progressLayer.shadowRadius = 2;
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGPoint center = CGPointMake(0.5 * rect.size.width, 0.5 * rect.size.height);
    CGFloat radius = 0.5 * rect.size.width;
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = -M_PI_2 + 2 * M_PI * _qh_progress;
    
    _progressLayer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    _progressLayer.path = path.CGPath;
    [_progressLayer removeFromSuperlayer];
    
    [self.layer addSublayer:_progressLayer];
}

- (void)setQh_progress:(CGFloat)qh_progress {
    
    _qh_progress = qh_progress;
    [self setNeedsDisplay];
}

@end
