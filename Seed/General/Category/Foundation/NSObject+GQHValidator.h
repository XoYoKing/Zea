//
//  NSObject+GQHValidator.h
//  Seed
//
//  Created by Mac on 2019/7/5.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GQHValidator)

/**
 密码以字母开头  只包含"字母" "数字" "下划线"  长度 6~18
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidPassword:(id)object;

/**
 移动、联通、电信手机号
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidMobile:(id)object;

/**
 验证码 (6位数字)
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidCAPTCHA:(id)object;

/**
 银行卡号
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidBankCardNumber:(id)object;

/**
 电子邮箱地址
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidEmail:(id)object;

/**
 身份证 (15位和18位)
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidIdentityCardNumber:(id)object;

/**
 纯中文字符
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isOnlyChinese:(id)object;

/**
 纯数字
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isOnlyNumber:(id)object;

/**
 浮点数
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidDecimal:(id)object;

/**
 字符串(含空字符串)
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidString:(id)object;

/**
 非空字符串
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isNotNullString:(id)object;

/**
 非空字典
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidDictionary:(id)object;

/**
 非空数组
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isValidArray:(id)object;

/**
 是否含有表情符号(emoji)
 
 @param object 任意对象
 @return YES or NO
 */
+ (BOOL)qh_isStringWithEmoji:(id)object;

/**
 对象内容的null、Null、NSNull转为@""
 
 @param object 任意对象
 @return 返回不含null、Null、NSNull的对象
 */
+ (id)qh_filterNull:(id)object;

@end

NS_ASSUME_NONNULL_END

/**
 使用NSObject分类的原因是被检查的对象存在以下几种情况:
 1、非字符串类(NSNULL,NSNull)
 2、空字符串(nil,NULL)
 */
