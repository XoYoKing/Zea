//
//  GQHStepperView.m
//  Seed
//
//  Created by GuanQinghao on 24/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHStepperView.h"

@interface GQHStepperView () <UITextFieldDelegate> {
    
    UIButton *leftButton;
    UITextField *middleTextField;
    UIButton *rightButton;
    
    NSUInteger value;
    NSUInteger maxValue;
    NSUInteger minValue;
}

@end

@implementation GQHStepperView

+ (instancetype)qh_stepperViewWithFrame:(CGRect)frame {
    
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self loadStepperView];
    }
    return self;
}

- (void)loadStepperView {
    
    maxValue = 99;
    minValue = 1;
    value = minValue;
    
    CGFloat sub_x = 0;
    CGFloat sub_y = 0;
    CGFloat sub_width = 0;
    CGFloat sub_height = 0;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    // 控件按照固定比例充满整个frame
    if ((3.5 * height) < (0.75 * width)) {
        //左右居中
        sub_x = (width - 3.5 * height / 0.75) / 2;
        sub_y = 0;
        sub_width = 3.5 * height / 0.75;
        sub_height = height;
        
    } else {
        //上下居中
        sub_x = 0;
        sub_y = (height - 0.75 * width / 3.5) / 2;
        sub_width = width;
        sub_height = 0.75 * width / 3.5;
    }
    
    //三个控件比例  height = 1:1:1   width = 1:1.5:1
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(sub_x, sub_y, sub_width, sub_height)];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 0.1 * sub_height;
    containerView.layer.borderWidth = 0.03 * sub_height;
    containerView.layer.borderColor = [UIColor redColor].CGColor;
    containerView.layer.masksToBounds = YES;
    [self addSubview:containerView];
    
    // 左边减按钮
    leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, sub_height / 0.75, sub_height)];
    
    leftButton.userInteractionEnabled = NO;
    leftButton.backgroundColor = [UIColor grayColor];
    
    leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftButton setImage:[UIImage imageNamed:@"stepperview_minus"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(minusValue:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:leftButton];
    
    // 中间值输入框
    middleTextField = [[UITextField alloc]initWithFrame:CGRectMake(sub_height / 0.75, 0, 2*sub_height, sub_height)];
    middleTextField.text = [NSString stringWithFormat:@"%lu",value];
    middleTextField.clearButtonMode = UITextFieldViewModeNever;
    middleTextField.keyboardType = UIKeyboardTypeNumberPad;
    middleTextField.textAlignment = NSTextAlignmentCenter;
    middleTextField.font = [UIFont systemFontOfSize:(0.7*sub_height)];
    middleTextField.delegate = self;
    [containerView addSubview:middleTextField];
    
    // 右边加按钮
    rightButton = [[UIButton alloc]initWithFrame:CGRectMake(sub_height /0.3, 0, sub_height / 0.75, sub_height)];
    rightButton.backgroundColor = [UIColor redColor];
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightButton setImage:[UIImage imageNamed:@"stepperview_plus"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(plusValue:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:rightButton];
    
    
    UIToolbar *keyToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45.0f)];
    keyToolBar.translucent = YES;
    keyToolBar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *spaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"done", @"完成") style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard:)];
    [keyToolBar setItems:@[spaceBarButtonItem,doneBarButtonItem]];
    middleTextField.inputAccessoryView = keyToolBar;
}

#pragma mark --PrivateMethod
- (IBAction)minusValue:(id)sender {
    
    [middleTextField resignFirstResponder];
    
    NSString *valueString = middleTextField.text;
    value = [valueString integerValue];
    
    if (--value > minValue) {
        
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        rightButton.userInteractionEnabled = YES;
        rightButton.backgroundColor = [UIColor redColor];
    } else {
        
        value = minValue;
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = NO;
        leftButton.backgroundColor = [UIColor grayColor];
    }
}

- (IBAction)plusValue:(id)sender {
    
    [middleTextField resignFirstResponder];
    
    NSString *valueString = middleTextField.text;
    value = [valueString integerValue];
    
    if (++value < maxValue) {
        
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = YES;
        leftButton.backgroundColor = [UIColor redColor];
    } else {
        
        value = maxValue;
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        rightButton.userInteractionEnabled = NO;
        rightButton.backgroundColor = [UIColor grayColor];
    }
}

- (IBAction)resignKeyboard:(id)sender {
    
    [middleTextField resignFirstResponder];
    
    NSString *valueString = middleTextField.text;
    value = [valueString integerValue];
    
    if (minValue < value && value < maxValue) {
        
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = YES;
        leftButton.backgroundColor = [UIColor redColor];
        rightButton.userInteractionEnabled = YES;
        rightButton.backgroundColor = [UIColor redColor];
    } else if (value <= minValue) {
        
        value = minValue;
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = NO;
        leftButton.backgroundColor = [UIColor grayColor];
        rightButton.userInteractionEnabled = YES;
        rightButton.backgroundColor = [UIColor redColor];
    } else {
        
        value = maxValue;
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = YES;
        leftButton.backgroundColor = [UIColor redColor];
        rightButton.userInteractionEnabled = NO;
        rightButton.backgroundColor = [UIColor grayColor];
    }
}

#pragma mark --Setter
- (void)setQh_value:(NSUInteger)qh_value {
    
    if (minValue < qh_value && qh_value < maxValue) {
        
        value = qh_value;
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = YES;
        leftButton.backgroundColor = [UIColor redColor];
        rightButton.userInteractionEnabled = YES;
        rightButton.backgroundColor = [UIColor redColor];
    } else if (qh_value <= minValue) {
        
        value = minValue;
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = NO;
        leftButton.backgroundColor = [UIColor grayColor];
        rightButton.userInteractionEnabled = YES;
        rightButton.backgroundColor = [UIColor redColor];
    } else {
        
        value = maxValue;
        middleTextField.text = [NSString stringWithFormat:@"%lu",value];
        
        leftButton.userInteractionEnabled = YES;
        leftButton.backgroundColor = [UIColor redColor];
        rightButton.userInteractionEnabled = NO;
        rightButton.backgroundColor = [UIColor grayColor];
    }
}

- (void)setQh_maxValue:(NSUInteger)qh_maxValue {
    
    if (qh_maxValue) {
        
        maxValue = qh_maxValue;
    }
}

- (void)setQh_minValue:(NSUInteger)qh_minValue {
    
    if (qh_minValue) {
        
        minValue = qh_minValue;
    }
}

#pragma mark --Getter
- (NSUInteger)qh_value {
    
    return value;
}

@end
