//
//  NSDate+GQHFormatter.h
//  Seed
//
//  Created by GuanQinghao on 2018/8/5.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, GQHDateTimeFormatterType) {
    
    /// yyyy年MM月dd日 HH时mm分ss秒
    GQHDateTimeFormatterTypeChinese,
    /// yyyy-MM-dd HH:mm:ss
    GQHDateTimeFormatterTypeHyphen,
    /// yyyy/MM/dd HH:mm:ss
    GQHDateTimeFormatterTypeSlash,
    
    /// yyyy年MM月dd日
    GQHDateTimeFormatterTypeChineseYearMonthDay,
    /// yyyy-MM-dd
    GQHDateTimeFormatterTypeHyphenYearMonthDay,
    /// yyyy/MM/dd
    GQHDateTimeFormatterTypeSlashYearMonthDay,
    
    /// MM月dd日
    GQHDateTimeFormatterTypeChineseMonthDay,
    /// MM/dd
    GQHDateTimeFormatterTypeSlashMonthDay,
    /// MM-dd
    GQHDateTimeFormatterTypeHyphenMonthDay,
    
    /// HH时mm分ss秒
    GQHDateTimeFormatterTypeChineseHourMinuteSecond,
    /// HH时mm分
    GQHDateTimeFormatterTypeChineseHourMinute,
    /// HH:mm:ss
    GQHDateTimeFormatterTypeColonHourMinuteSecond,
    /// HH:mm
    GQHDateTimeFormatterTypeColonHourMinute
};


@interface NSDate (GQHFormatter)

/// 日期格式化单例
@property (nonatomic, readonly, class) NSDateFormatter *qh_defaultDateFormatter;
+ (NSDateFormatter *)qh_defaultDateFormatter;

/// 时间戳(1970 单位秒)格式化为时间差
+ (NSString *)qh_formatterTimeDifferenceWith:(NSTimeInterval)timeStamp;

/// 时间戳(1970 单位秒)格式化为指定字符串
+ (NSString *)qh_formatterDateStringWithTimeStamp:(NSTimeInterval)timeStamp formatter:(GQHDateTimeFormatterType)formatterType;
/// 字符串格式化为时间戳(1970 单位秒)
+ (NSTimeInterval)qh_formatterTimeStampWithDateString:(NSString *)dateString formatter:(GQHDateTimeFormatterType)formatterType;
/// 字符串格式化为时间类型
+ (NSDate *)qh_formatterDateWithDateString:(NSString *)dateString formatter:(GQHDateTimeFormatterType)formatterType;
/// 时间类型格式化为指定字符串
+ (NSString *)qh_formatterDateStringWithDate:(NSDate *)date formatter:(GQHDateTimeFormatterType)formatterType;
/// 枚举类型值(NSString)
+ (NSString *)formatterTypeStringWith:(GQHDateTimeFormatterType)formatterType;

/// 是否为昨天
- (BOOL)qh_isYesterday;
/// 是否为今天
- (BOOL)qh_isToday;
/// 是否为明天
- (BOOL)qh_isTomorrow;
/// 是否为今年
- (BOOL)qh_isThisYear;

@end
