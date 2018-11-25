//
//  GQHAnimateDotView.m
//  Seed
//
//  Created by GuanQinghao on 12/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHAnimateDotView.h"


// 动画时长
static CGFloat const kAnimationDuration = 1.0f;


@implementation GQHAnimateDotView

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self initialization];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initialization];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialization];
    }
    
    return self;
}

- (void)initialization {
    
    self.qh_dotColor = UIColor.whiteColor;
    self.backgroundColor = UIColor.clearColor;
    self.layer.cornerRadius = 0.5 * CGRectGetWidth(self.frame);
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 2.0;
//    self.layer.masksToBounds = YES; // 阴影效果会失效
}

- (void)qh_checkState:(BOOL)activated {
    
    if (activated) {
        
        [self animateForActivedState];
    } else {
        
        [self animateForDeactivedState];
    }
}

- (void)animateForActivedState {
    
    [UIView animateWithDuration:kAnimationDuration delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:-20.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.backgroundColor = self.qh_dotColor;
        self.transform = CGAffineTransformMakeScale(1.4f, 1.4f);
    } completion:nil];
}

- (void)animateForDeactivedState {
    
    [UIView animateWithDuration:kAnimationDuration delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.backgroundColor = UIColor.clearColor;
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)setQh_dotColor:(UIColor *)qh_dotColor {
    
    _qh_dotColor = qh_dotColor;
    self.layer.borderColor = qh_dotColor.CGColor;
}

@end
