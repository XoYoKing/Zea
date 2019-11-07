//
//  NSString+GQHFormatter.h
//  Seed
//
//  Created by GuanQinghao on 16/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSString (GQHFormatter)

/**
 手机号隐藏格式化 (保留前三位后四位)
 
 @param mobile 手机号
 @return 隐藏的手机号(保留前三位后四位)
 */
+ (NSString *)qh_formatterSecretStringWithMobile:(NSString *)mobile;

/**
 身份证/银行卡/信用卡格式化 (保留前四位后四位)
 
 @param cardNumber 身份证/银行卡/信用卡卡号
 @return 隐藏的身份证/银行卡/信用卡卡号(保留前四位后四位)
 */
+ (NSString *)qh_formatterSecretStringWithCardNumber:(NSString *)cardNumber;

/**
 数量转中文单位
 
 @param value 数量值
 @return 带中文单位的数量
 */
+ (NSString *)qh_formatterChineseAmountStringWithValue:(CGFloat)value;

/**
 计算文本的大小
 
 @param font 文本字体
 @param maxSize 最大size
 @return 计算后的文本size
 */
- (CGSize)qh_formatterSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
