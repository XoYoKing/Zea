//
//  UIView+GQHHUD.m
//  Seed
//
//  Created by Mac on 2018/10/16.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIView+GQHHUD.h"
#import <MBProgressHUD.h>


@implementation UIView (GQHHUD)

+ (instancetype)shareHUD {
    
    static MBProgressHUD *HUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
        HUD.removeFromSuperViewOnHide = YES;
    });
    
    return HUD;
}

- (void)showHUD {
    
    [self showHUDWithText:@""];
}

- (void)showHUDWithText:(NSString *)text {
    
    MBProgressHUD *HUD = [[self class] shareHUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.label.text = text;
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    [HUD showAnimated:YES];
}

- (void)hideHUD {
    
    [[[self class] shareHUD] hideAnimated:YES];
}

- (void)showToastWithText:(NSString *)toastString {
    
    CGPoint offset = CGPointMake(0.0f, 0.5f * CGRectGetHeight([UIScreen mainScreen].bounds));
    
    [self showToastWithText:toastString offset:offset];
}

- (void)showToastWithText:(NSString *)toastString offset:(CGPoint)offset {
    
    if (toastString && toastString.length > 0) {
        
        MBProgressHUD *HUD = [[self class] shareHUD];
        HUD.mode = MBProgressHUDModeText;
        HUD.label.text = toastString;
        HUD.offset = offset;
        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
        [HUD showAnimated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self hideHUD];
        });
    }
}

- (void)showToastWithText:(NSString *)toastString afterDelay:(NSTimeInterval)timeInterval {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showToastWithText:toastString];
    });
}

@end


@implementation UIViewController (GQHHUD)

- (void)showHUD {
    
    [self.view showHUD];
}

- (void)showHUDWithText:(NSString *)text {
    
    [self.view showHUDWithText:text];
}

- (void)hideHUD {
    
    [self.view hideHUD];
}

- (void)showToastWithText:(NSString *)toastString {
    
    [self.view showToastWithText:toastString];
}

- (void)showToastWithText:(NSString *)toastString offset:(CGPoint)offset {
    
    [self.view showToastWithText:toastString offset:offset];
}

- (void)showToastWithText:(NSString *)toastString afterDelay:(NSTimeInterval)timeInterval {
    
    [self.view showToastWithText:toastString afterDelay:timeInterval];
}

@end
