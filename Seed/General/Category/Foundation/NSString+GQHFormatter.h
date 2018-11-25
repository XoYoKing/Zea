//
//  NSString+GQHFormatter.h
//  Seed
//
//  Created by GuanQinghao on 16/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (GQHFormatter)

/// 手机号隐藏格式化 (保留前三位后四位)
+ (NSString *)qh_formatterSecretStringWithMobile:(NSString *)mobile;
/// 银行卡／信用卡格式化 (保留前四位后四位)
+ (NSString *)qh_formatterSecretStringWithCardNumber:(NSString *)cardNumber;
/// 数量转中文单位
+ (NSString *)qh_formatterChineseAmountStringWithValue:(CGFloat)value;
/// 计算文本的大小
- (CGSize)qh_formatterSizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
