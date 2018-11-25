//
//  UIViewController+GQHAlert.m
//  Seed
//
//  Created by Mac on 2018/7/27.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "UIViewController+GQHAlert.h"

@implementation UIViewController (GQHAlert)

/// 警告弹窗 (确定)/(自定义|取消)
- (void)qh_alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message actionTitle:(NSString *_Nullable)actionTitle handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler completion:(void (^ __nullable)(void))completion {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message: message preferredStyle:UIAlertControllerStyleAlert];
    
    if (actionTitle) {
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:handler]];
    } else {
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler]];
    }
    
    [self presentViewController:alertController animated:YES completion:completion];
}

/// 带输入框的警告弹窗
- (void)qh_alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message inputHandler:(void (^ __nullable)(UITextField * _Nullable textField))inputHandler actionHandler:(void (^ __nullable)(UIAlertAction * _Nullable action, UIAlertController * _Nonnull alertController))actionHandler completion:(void (^ __nullable)(void))completion {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message: message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:inputHandler];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        actionHandler(action,alertController);
    }]];
    
    [self presentViewController:alertController animated:YES completion:completion];
}

@end
