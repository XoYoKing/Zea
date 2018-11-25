//
//  NSString+GQHPredicate.h
//  Seed
//
//  Created by GuanQinghao on 17/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (GQHPredicate)

/// 密码以字母开头  只包含"字母" "数字" "下划线"  长度 6~18
- (BOOL)qh_isValidPassword;
/// 移动、联通、电信手机号
- (BOOL)qh_isValidMobile;
/// 验证码 可自定义
- (BOOL)qh_isValidCAPTCHA;
/// 银行卡号
- (BOOL)qh_isValidBankCardNumber;
/// 邮箱
- (BOOL)qh_isValidEmail;
/// 身份证 (15位和18位)
- (BOOL)qh_isValidIdentityCardNo;
/// 中文字符
- (BOOL)qh_isOnlyChinese;
/// 数字
- (BOOL)qh_isOnlyNumber;
/// 浮点数
- (BOOL)qh_isValidDecimal;

@end
