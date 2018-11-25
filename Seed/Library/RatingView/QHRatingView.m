//
//  QHRatingView.m
//  
//
//  Created by GuanQinghao on 26/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "QHRatingView.h"

@interface QHRatingView () {
    
    NSInteger ratingValue;
    BOOL oneStar;
}

@end

@implementation QHRatingView

+ (instancetype)ratingViewWithFrame:(CGRect)frame {
    
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    if (self) {
        
        ratingValue = 99;
        oneStar = NO;
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        CGFloat sub_x = 0;
        CGFloat sub_y = 0;
        CGFloat sub_width = 0;
        CGFloat sub_height = 0;
        CGFloat edgeInset = 0;
        CGFloat spacing = 0;
        
        if ((5 * height) < width) {
            
            // 适配高度
            sub_x = 0;
            sub_y = 0;
            sub_width = height;
            sub_height = height;
            spacing = 0.25 * (width - 5 * height);
            edgeInset = 0.2 * sub_height;
        } else {
            
            // 适配宽度
            sub_x = 0;
            sub_y = 0.5 * height - 0.1 * width;
            sub_width = 0.2 * width;
            sub_height = 0.2 * width;
            spacing = 0;
            edgeInset = 0.2 * sub_height;
        }
        
        for (NSInteger i = 0; i < 5; i++) {
            
            UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [iconButton setFrame:CGRectMake(i * (sub_height + spacing), sub_y, sub_width, sub_height)];
            [iconButton setTag:(i + 9900)];
            [iconButton setAdjustsImageWhenHighlighted:NO];
            [iconButton setImage:[UIImage imageNamed:@"rating_default"] forState:UIControlStateNormal];
            [iconButton setImageEdgeInsets:UIEdgeInsetsMake(edgeInset, edgeInset, edgeInset, edgeInset)];
            [iconButton addTarget:self action:@selector(rating:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:iconButton];
        }
    }
    
    return self;
}

- (IBAction)rating:(UIButton *)sender {
    
    if (sender.tag == 9900 && oneStar && _worst) {
        
        for (NSInteger i = 0; i < 5; i++) {
            
            UIButton *button = (UIButton *)[self viewWithTag:(i + 9900)];
            [button setImage:[UIImage imageNamed:@"rating_awful"] forState:UIControlStateNormal];
        }
        ratingValue = 0;
        oneStar = NO;
    } else {
        
        for (NSInteger i = 0; i < 5; i++) {
            
            UIButton *button = (UIButton *)[self viewWithTag:(i + 9900)];
            [button setImage:[UIImage imageNamed:@"rating_default"] forState:UIControlStateNormal];
            
            if (sender.tag == 9904) {
                
                [button setImage:[UIImage imageNamed:@"rating_greatest"] forState:UIControlStateNormal];
                ratingValue = sender.tag - 9900 + 1;
                oneStar = NO;
            }
            if (9902 <= sender.tag && sender.tag < 9904) {
                
                if (button.tag <= sender.tag) {
                    
                    [button setImage:[UIImage imageNamed:@"rating_greater"] forState:UIControlStateNormal];
                }
                ratingValue = sender.tag - 9900 + 1;
                oneStar = NO;
            }
            if (sender.tag == 9901) {
                
                if (button.tag <= sender.tag) {
                    
                    [button setImage:[UIImage imageNamed:@"rating_normal"] forState:UIControlStateNormal];
                }
                ratingValue = sender.tag - 9900 + 1;
                oneStar = NO;
            }
            if (sender.tag == 9900 && !oneStar) {
                
                [sender setImage:[UIImage imageNamed:@"rating_normal"] forState:UIControlStateNormal];
                ratingValue = 1;
                oneStar = YES;
                if (!_worst) {
                    
                    oneStar = NO;
                }
            }
        }
    }
}

- (NSInteger)ratingValue {
    
    if (ratingValue == 99) {
#warning
        NSAssert(YES, @"do not select rating level!");
    }
    
    return ratingValue;
}

@end
