//
//  ViewController.m
//  TouchID
//
//  Created by QinghaoGuan on 16/7/24.
//  Copyright © 2016年 QinghaoGuan. All rights reserved.
//

#import "ViewController.h"
#import "TouchID.h"

@interface ViewController ()<TouchIDDelegate>

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@property (nonatomic, strong) TouchID *touchID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TouchID *touch_ID = [[TouchID alloc]init];
    
    [touch_ID startTouchIDWithMessage:Notice(@"自定义信息", @"The Custom Message") fallbackTitle:Notice(@"按钮标题", @"Fallback Title") delegate:self];
    
    self.touchID = touch_ID;
    
}

- (IBAction)StartWJTouchID {
    [self.touchID startTouchIDWithMessage:Notice(@"这里可以自定义", @"The Custom Message") fallbackTitle:Notice(@"按钮标题", @"Fallback Title") delegate:self];
}

#pragma mark TouchIDDelegate required
/**
 *  TouchID验证成功
 *
 *  Authentication Successul
 */
- (void)TouchIDAuthorizeSuccess{
    self.noticeLabel.text = Notice(@"TouchID验证成功", @"Authorize Success");
}

/**
 *  TouchID验证失败
 *
 *  Authentication Failure
 */
- (void)TouchIDAuthorizeFailure{
    self.noticeLabel.text = Notice(@"TouchID验证失败", @"Authorize Failure");
}
#pragma mark TouchIDDelegate optional
/**
 *  取消TouchID验证 (用户点击了取消)
 *
 *  Authentication was canceled by user (e.g. tapped Cancel button).
 */
- (void)TouchIDAuthorizeErrorUserCancel{
    self.noticeLabel.text = Notice(@"取消TouchID验证 (用户点击了取消)", @"Authorize Error User Cancel");
}

/**
 *  在TouchID对话框中点击输入密码按钮
 *
 *  User tapped the fallback button
 */
- (void)TouchIDAuthorizeErrorUserFallback{
    self.noticeLabel.text = Notice(@"在TouchID对话框中点击输入密码按钮", @"Authorize Error User Fallback ");
}

/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 *
 *  Authentication was canceled by system (e.g. another application went to foreground).
 */
- (void)TouchIDAuthorizeErrorSystemCancel{
    self.noticeLabel.text = Notice(@"在验证的TouchID的过程中被系统取消 ", @"Authorize Error System Cancel");
}

/**
 *  无法启用TouchID,设备没有设置密码
 *
 *  Authentication could not start, because passcode is not set on the device.
 */
- (void)TouchIDAuthorizeErrorPasscodeNotSet{
    self.noticeLabel.text = Notice(@"无法启用TouchID,设备没有设置密码", @"Authorize Error Passcode Not Set");
}

/**
 *  设备没有录入TouchID,无法启用TouchID
 *
 *  Authentication could not start, because Touch ID has no enrolled fingers
 */
- (void)TouchIDAuthorizeErrorTouchIDNotEnrolled{
    self.noticeLabel.text = Notice(@"设备没有录入TouchID,无法启用TouchID", @"Authorize Error TouchID Not Enrolled");
}

/**
 *  该设备的TouchID无效
 *
 *  Authentication could not start, because Touch ID is not available on the device.
 */
- (void)TouchIDAuthorizeErrorTouchIDNotAvailable{
    self.noticeLabel.text = Notice(@"该设备的TouchID无效", @"Authorize Error TouchID Not Available");
}

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 *
 *  Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
 *
 */
- (void)TouchIDAuthorizeErrorTouchIDLockout{
    self.noticeLabel.text = Notice(@"多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁", @"Authorize LAError TouchID Lockout");
}

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 *
 *  Authentication was canceled by application (e.g. invalidate was called while authentication was inprogress).
 *
 */
- (void)TouchIDAuthorizeErrorAppCancel{
    self.noticeLabel.text = Notice(@"当前软件被挂起取消了授权", @"Authorize LAError AppCancel");
}

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 *
 *  LAContext passed to this call has been previously invalidated.
 */
- (void)TouchIDAuthorizeErrorInvalidContext{
    self.noticeLabel.text = Notice(@"当前软件被挂起取消了授权", @"Authorize LAError Invalid Context");
}

/**
 *  当前设备不支持指纹识别
 *
 *  The current device does not support fingerprint identification
 */
-(void)TouchIDIsNotSupport{
    self.noticeLabel.text = Notice(@"当前设备不支持指纹识别", @"The Current Device Does Not Support");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
