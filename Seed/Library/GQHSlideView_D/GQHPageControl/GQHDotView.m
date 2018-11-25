//
//  GQHDotView.m
//  Seed
//
//  Created by GuanQinghao on 12/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHDotView.h"

@implementation GQHDotView

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
    
    self.backgroundColor = UIColor.clearColor;
    self.layer.cornerRadius = 0.5 * CGRectGetWidth(self.frame);
    self.layer.borderColor = UIColor.whiteColor.CGColor;
    self.layer.borderWidth = 2.0;
//    self.layer.masksToBounds = YES; // 阴影效果会失效
}

- (void)qh_checkState:(BOOL)activated {
    
    if (activated) {
        
        self.backgroundColor = UIColor.whiteColor;
    } else {
        
        self.backgroundColor = UIColor.clearColor;
    }
}

@end
