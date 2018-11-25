//
//  GQHStepperView.h
//  Seed
//
//  Created by GuanQinghao on 24/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQHStepperView : UIView

@property (nonatomic, assign) NSUInteger qh_value;// 当前值
@property (nonatomic, assign) NSUInteger qh_maxValue;// 最大值 默认99
@property (nonatomic, assign) NSUInteger qh_minValue;// 最小值 默认1

+ (instancetype)qh_stepperViewWithFrame:(CGRect)frame;

@end
