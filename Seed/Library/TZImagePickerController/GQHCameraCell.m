//
//  GQHCameraCell.m
//  GQHKit
//
//  Created by GuanQinghao on 07/02/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHCameraCell.h"

@implementation GQHCameraCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _qh_imageView = [[UIImageView alloc] init];
        _qh_imageView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _qh_imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_qh_imageView];
        
        self.clipsToBounds = YES;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _qh_imageView.frame = self.bounds;
}

@end
