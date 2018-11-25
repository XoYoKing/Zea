//
//  UIView+GQHHUD.h
//  Seed
//
//  Created by Mac on 2018/10/16.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GQHHUDDelegate <NSObject>

- (void)showHUD;
- (void)showHUDWithText:(NSString *)text;
- (void)hideHUD;

- (void)showToastWithText:(NSString *)toastString;
- (void)showToastWithText:(NSString *)toastString offset:(CGPoint)offset;
- (void)showToastWithText:(NSString *)toastString afterDelay:(NSTimeInterval)timeInterval;

@end


@interface UIView (GQHHUD) <GQHHUDDelegate>

@end


@interface UIViewController (GQHHUD) <GQHHUDDelegate>

@end
