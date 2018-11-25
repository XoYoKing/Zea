//
//  UIViewController+GQHAlert.h
//  Seed
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GQHAlert)

/// 警告弹窗  (确定)/(自定义|取消)
- (void)qh_alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message actionTitle:(NSString *_Nullable)actionTitle handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler completion:(void (^ __nullable)(void))completion;

/// 带输入框的警告弹窗
- (void)qh_alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message inputHandler:(void (^ __nullable)(UITextField * _Nullable textField))inputHandler actionHandler:(void (^ __nullable)(UIAlertAction * _Nullable action, UIAlertController * _Nonnull alertController))actionHandler completion:(void (^ __nullable)(void))completion;

@end
