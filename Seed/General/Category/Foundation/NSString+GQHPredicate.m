//
//  NSString+GQHPredicate.m
//  Seed
//
//  Created by GuanQinghao on 17/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSString+GQHPredicate.h"


@implementation NSString (GQHPredicate)

// 密码以字母开头  只包含"字母" "数字" "下划线"  长度 6~18
- (BOOL)qh_isValidPassword {
    
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_]{5,17}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
    return [predicate evaluateWithObject:self];
}

// 移动、联通、电信手机号
- (BOOL)qh_isValidMobile {
    
    if (self.length == 11) {
        
        // 移动号段正则表达式
        NSString *reg_CM = @"^((13[4-9])|(198)|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        // 联通号段正则表达式
        NSString *reg_CU = @"^((13[0-2])|(166)|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        // 电信号段正则表达式
        NSString *reg_CT = @"^((133)|(153)|(199)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred_CM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg_CM];
        BOOL isMatch_CM = [pred_CM evaluateWithObject:self];
        
        NSPredicate *pred_CU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg_CU];
        BOOL isMatch_CU = [pred_CU evaluateWithObject:self];
        
        NSPredicate *pred_CT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg_CT];
        BOOL isMatch_CT = [pred_CT evaluateWithObject:self];
        
        return (isMatch_CM || isMatch_CU || isMatch_CT);
    }
    
    return NO;
}

// 验证码 可自定义
- (BOOL)qh_isValidCAPTCHA {
    
    NSString *regex = @"^[0-9]{6}"; // 六位数字
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}

// 银行卡号
- (BOOL)qh_isValidBankCardNumber {
    
    NSString *regex = @"^(\\d{16}|\\d{19})$"; // 银行卡号16位或19位
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:self];
}

// 邮箱
- (BOOL)qh_isValidEmail {
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}

// 身份证 (15位和18位)
- (BOOL)qh_isValidIdentityCardNo {
    
    NSString *regex15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex15];
    
    NSString *regex18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex18];
    
    return ([predicate15 evaluateWithObject:self] || [predicate18 evaluateWithObject:self]);
}

// 中文字符
- (BOOL)qh_isOnlyChinese {
    
    NSString *regex = @"^[\u4e00-\u9fa5]*$"; // 只有中文字符
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:self];
}

// 数字
- (BOOL)qh_isOnlyNumber {
    
    NSString *regex = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:self];
}

// 浮点数
- (BOOL)qh_isValidDecimal {
    
    NSString *regex = @"^[0-9]+\\.[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [predicate evaluateWithObject:self];
}

@end
