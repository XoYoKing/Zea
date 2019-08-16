//
//  NSDate+GQHFormatter.m
//  Seed
//
//  Created by GuanQinghao on 2018/8/5.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSDate+GQHFormatter.h"


static NSString * const kDateTimeFormatterTypeChinese = @"yyyy年MM月dd日 HH时mm分ss秒";
static NSString * const kDateTimeFormatterTypeHyphen = @"yyyy-MM-dd HH:mm:ss";
static NSString * const kDateTimeFormatterTypeSlash = @"yyyy/MM/dd HH:mm:ss";
static NSString * const kDateTimeFormatterTypeChineseYearMonthDay = @"yyyy年MM月dd日";
static NSString * const kDateTimeFormatterTypeHyphenYearMonthDay = @"yyyy-MM-dd";
static NSString * const kDateTimeFormatterTypeSlashYearMonthDay = @"yyyy/MM/dd";
static NSString * const kDateTimeFormatterTypeChineseMonthDay = @"MM月dd日";
static NSString * const kDateTimeFormatterTypeSlashMonthDay = @"MM/dd";
static NSString * const kDateTimeFormatterTypeHyphenMonthDay = @"MM-dd";
static NSString * const kDateTimeFormatterTypeChineseHourMinuteSecond = @"HH时mm分ss秒";
static NSString * const kDateTimeFormatterTypeChineseHourMinute = @"HH时mm分";
static NSString * const kDateTimeFormatterTypeColonHourMinuteSecond = @"HH:mm:ss";
static NSString * const kDateTimeFormatterTypeColonHourMinute = @"HH:mm";


@implementation NSDate (GQHFormatter)

/**
 时间格式化单例
 
 @return 时间格式化单例
 */
+ (NSDateFormatter *)qh_defaultDateFormatter {
    
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        formatter = [[NSDateFormatter alloc] init];
    });
    
    return formatter;
}

/**
 时间戳(1970 单位秒)格式化为时间差
 
 @param timeStamp 时间戳(1970 单位秒)
 @return 时间差
 */
+ (NSString *)qh_formatterTimeDifferenceWith:(NSTimeInterval)timeStamp {
    
    // 第一步，获取当前系统的时间戳
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    // 第二步，计算时间戳差值
    NSTimeInterval dif = timeInterval - timeStamp;
    // 第三步，根据时间戳设置样式
    NSString *string;
    NSInteger result = 0;
    
    if (dif < 60) {
        
        string = [NSString stringWithFormat:@"刚刚"];
    } else if ((result = dif / 60) < 60) {
        
        string = [NSString stringWithFormat:@"%ld分钟前", result];
    } else if ((result = result / 60) < 24) {
        
        string = [NSString stringWithFormat:@"%ld小时前", result];
    } else if ((result = result / 24) < 30) {
        
        string = [NSString stringWithFormat:@"%ld天前",result];
    } else if ((result = result / 30) < 12) {
        
        string = [NSString stringWithFormat:@"%ld月前",result];
    } else {
        
        result = result / 12;
        string = [NSString stringWithFormat:@"%ld年前",result];
    }
    
    return  string;
}

/**
 时间戳(1970 单位秒)格式化为指定字符串
 
 @param timeStamp 时间戳(1970 单位秒)
 @param formatterType 时间格式化样式
 @return 指定时间格式字符串
 */
+ (NSString *)qh_formatterDateStringWithTimeStamp:(NSTimeInterval)timeStamp formatter:(GQHDateTimeFormatterType)formatterType {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000];
    
    NSDateFormatter *dateFormatter = NSDate.qh_defaultDateFormatter;
    dateFormatter.dateFormat = [self formatterTypeStringWith:formatterType];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

/**
 字符串格式化为时间戳(1970 单位秒)
 
 @param dateString 时间字符串
 @param formatterType 时间格式化样式
 @return 时间戳(1970 单位秒)
 */
+ (NSTimeInterval)qh_formatterTimeStampWithDateString:(NSString *)dateString formatter:(GQHDateTimeFormatterType)formatterType {
    
    // 把字符串格式化为时间
    NSDate *date = [self qh_formatterDateWithDateString:dateString formatter:formatterType];
    // 时间转时间戳
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    
    return timeStamp;
}

/**
 字符串格式化为时间类型
 
 @param dateString 时间字符串
 @param formatterType 时间格式化样式
 @return 时间类型
 */
+ (NSDate *)qh_formatterDateWithDateString:(NSString *)dateString formatter:(GQHDateTimeFormatterType)formatterType {
    
    // 设置日期格式化
    NSDateFormatter *dateFormatter = NSDate.qh_defaultDateFormatter;
    dateFormatter.dateFormat = [self formatterTypeStringWith:formatterType];
    // 根据日期字符串获取日期
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return date;
}

/**
 时间类型格式化为指定字符串
 
 @param date 时间类型
 @param formatterType 时间格式化样式
 @return 指定时间字符串
 */
+ (NSString *)qh_formatterDateStringWithDate:(NSDate *)date formatter:(GQHDateTimeFormatterType)formatterType {
    
    // 设置日期格式化
    NSDateFormatter *dateFormatter = NSDate.qh_defaultDateFormatter;
    dateFormatter.dateFormat = [self formatterTypeStringWith:formatterType];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

/**
 枚举类型值(NSString)
 
 @param formatterType 时间格式化样式
 @return 时间格式化字符串
 */
+ (NSString *)formatterTypeStringWith:(GQHDateTimeFormatterType)formatterType {
    
    switch (formatterType) {
            
        case GQHDateTimeFormatterTypeChinese:
            return kDateTimeFormatterTypeChinese;
        case GQHDateTimeFormatterTypeHyphen:
            return kDateTimeFormatterTypeHyphen;
        case GQHDateTimeFormatterTypeSlash:
            return kDateTimeFormatterTypeSlash;
        case GQHDateTimeFormatterTypeChineseYearMonthDay:
            return kDateTimeFormatterTypeChineseYearMonthDay;
        case GQHDateTimeFormatterTypeHyphenYearMonthDay:
            return kDateTimeFormatterTypeHyphenYearMonthDay;
        case GQHDateTimeFormatterTypeSlashYearMonthDay:
            return kDateTimeFormatterTypeSlashYearMonthDay;
        case GQHDateTimeFormatterTypeChineseMonthDay:
            return kDateTimeFormatterTypeChineseMonthDay;
        case GQHDateTimeFormatterTypeSlashMonthDay:
            return kDateTimeFormatterTypeSlashMonthDay;
        case GQHDateTimeFormatterTypeHyphenMonthDay:
            return kDateTimeFormatterTypeHyphenMonthDay;
        case GQHDateTimeFormatterTypeChineseHourMinuteSecond:
            return kDateTimeFormatterTypeChineseHourMinuteSecond;
        case GQHDateTimeFormatterTypeChineseHourMinute:
            return kDateTimeFormatterTypeChineseHourMinute;
        case GQHDateTimeFormatterTypeColonHourMinuteSecond:
            return kDateTimeFormatterTypeColonHourMinuteSecond;
        case GQHDateTimeFormatterTypeColonHourMinute:
            return kDateTimeFormatterTypeColonHourMinute;
    }
}

/**
 是否为昨天
 
 @return 是否为昨天
 */
- (BOOL)qh_isYesterday {
    
    NSDateFormatter *dateFormatter = NSDate.qh_defaultDateFormatter;
    dateFormatter.dateFormat = kDateTimeFormatterTypeHyphenYearMonthDay;
    
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *nowDate = [dateFormatter dateFromString:nowString];
    
    NSString *selfString = [dateFormatter stringFromDate:self];
    NSDate *selfDate = [dateFormatter dateFromString:selfString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 1;
}

/**
 是否为今天
 
 @return 是否为今天
 */
- (BOOL)qh_isToday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate: [NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return nowComponents.year == selfComponents.year && nowComponents.month == selfComponents.month && nowComponents.day == selfComponents.day;
}

/**
 是否为明天
 
 @return 是否为明天
 */
- (BOOL)qh_isTomorrow {
    
    NSDateFormatter *dateFormatter = NSDate.qh_defaultDateFormatter;
    dateFormatter.dateFormat = kDateTimeFormatterTypeHyphenYearMonthDay;
    
    NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *nowDate = [dateFormatter dateFromString:nowString];
    
    NSString *selfString = [dateFormatter stringFromDate:self];
    NSDate *selfDate = [dateFormatter dateFromString:selfString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return components.year == 0 && components.month == 0 && components.day == -1;
}

/**
 是否为今年
 
 @return 是否为今年
 */
- (BOOL)qh_isThisYear {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate: [NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

@end
