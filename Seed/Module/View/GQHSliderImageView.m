//
//  GQHSliderImageView.m
//  Seed
//
//  Created by GuanQinghao on 04/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHSliderImageView.h"
#import "GQHHeader.h"

@implementation GQHSliderImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.masksToBounds = YES;
    }
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    
    if (self) {
        
        self = [self initWithFrame:CGRectZero];
        self.image = image;
    }
    
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([_qh_delegate respondsToSelector:@selector(qh_slide:)]) {
        
        [_qh_delegate qh_slide:self];
    }
}

@end

