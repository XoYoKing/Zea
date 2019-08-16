//
//  NSDate+GQHFormatter.h
//  Seed
//
//  Created by GuanQinghao on 2018/8/5.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 时间格式样式

 - GQHDateTimeFormatterTypeChinese: yyyy年MM月dd日 HH时mm分ss秒
 - GQHDateTimeFormatterTypeHyphen: yyyy-MM-dd HH:mm:ss
 - GQHDateTimeFormatterTypeSlash: yyyy/MM/dd HH:mm:ss
 - GQHDateTimeFormatterTypeChineseYearMonthDay: yyyy年MM月dd日
 - GQHDateTimeFormatterTypeHyphenYearMonthDay: yyyy-MM-dd
 - GQHDateTimeFormatterTypeSlashYearMonthDay: yyyy/MM/dd
 - GQHDateTimeFormatterTypeChineseMonthDay: MM月dd日
 - GQHDateTimeFormatterTypeSlashMonthDay: MM/dd
 - GQHDateTimeFormatterTypeHyphenMonthDay: MM-dd
 - GQHDateTimeFormatterTypeChineseHourMinuteSecond: HH时mm分ss秒
 - GQHDateTimeFormatterTypeChineseHourMinute: HH时mm分
 - GQHDateTimeFormatterTypeColonHourMinuteSecond: HH:mm:ss
 - GQHDateTimeFormatterTypeColonHourMinute: HH:mm
 */
typedef NS_ENUM(NSUInteger, GQHDateTimeFormatterType) {
    
    GQHDateTimeFormatterTypeChinese,
    GQHDateTimeFormatterTypeHyphen,
    GQHDateTimeFormatterTypeSlash,
    GQHDateTimeFormatterTypeChineseYearMonthDay,
    GQHDateTimeFormatterTypeHyphenYearMonthDay,
    GQHDateTimeFormatterTypeSlashYearMonthDay,
    GQHDateTimeFormatterTypeChineseMonthDay,
    GQHDateTimeFormatterTypeSlashMonthDay,
    GQHDateTimeFormatterTypeHyphenMonthDay,
    GQHDateTimeFormatterTypeChineseHourMinuteSecond,
    GQHDateTimeFormatterTypeChineseHourMinute,
    GQHDateTimeFormatterTypeColonHourMinuteSecond,
    GQHDateTimeFormatterTypeColonHourMinute,
};


/**
 时间格式化
 */
@interface NSDate (GQHFormatter)

/**
 日期格式化单例
 */
@property (nonatomic, readonly, class) NSDateFormatter *qh_defaultDateFormatter;

/**
 时间格式化单例

 @return 时间格式化单例
 */
+ (NSDateFormatter *)qh_defaultDateFormatter;

/**
 时间戳(1970 单位秒)格式化为时间差

 @param timeStamp 时间戳(1970 单位秒)
 @return 时间差
 */
+ (NSString *)qh_formatterTimeDifferenceWith:(NSTimeInterval)timeStamp;

/**
 时间戳(1970 单位秒)格式化为指定字符串

 @param timeStamp 时间戳(1970 单位秒)
 @param formatterType 时间格式化样式
 @return 指定时间格式字符串
 */
+ (NSString *)qh_formatterDateStringWithTimeStamp:(NSTimeInterval)timeStamp formatter:(GQHDateTimeFormatterType)formatterType;

/**
 字符串格式化为时间戳(1970 单位秒)

 @param dateString 时间字符串
 @param formatterType 时间格式化样式
 @return 时间戳(1970 单位秒)
 */
+ (NSTimeInterval)qh_formatterTimeStampWithDateString:(NSString *)dateString formatter:(GQHDateTimeFormatterType)formatterType;

/**
 字符串格式化为时间类型

 @param dateString 时间字符串
 @param formatterType 时间格式化样式
 @return 时间类型
 */
+ (NSDate *)qh_formatterDateWithDateString:(NSString *)dateString formatter:(GQHDateTimeFormatterType)formatterType;

/**
 时间类型格式化为指定字符串

 @param date 时间类型
 @param formatterType 时间格式化样式
 @return 指定时间字符串
 */
+ (NSString *)qh_formatterDateStringWithDate:(NSDate *)date formatter:(GQHDateTimeFormatterType)formatterType;

/**
 枚举类型值(NSString)

 @param formatterType 时间格式化样式
 @return 时间格式化字符串
 */
+ (NSString *)formatterTypeStringWith:(GQHDateTimeFormatterType)formatterType;

/**
 是否为昨天

 @return 是否为昨天
 */
- (BOOL)qh_isYesterday;

/**
 是否为今天

 @return 是否为今天
 */
- (BOOL)qh_isToday;

/**
 是否为明天

 @return 是否为明天
 */
- (BOOL)qh_isTomorrow;

/**
 是否为今年

 @return 是否为今年
 */
- (BOOL)qh_isThisYear;

@end
