//
//  GQHDatePickerView.h
//  Seed
//
//  Created by Mac on 2018/12/17.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/**
 日期选择回调block

 @param selectedString 选择的日期字符串
 */
typedef void(^GQHDatePickerViewBlock)(NSString * _Nullable selectedString);


@interface GQHDatePickerView : UIView

/**
 日期选择回调
 */
@property (nonatomic, copy) GQHDatePickerViewBlock _Nullable qh_block;

/**
 时间选择模式, 默认日期时间选择模式
 */
@property (nonatomic) UIDatePickerMode qh_datePickerMode;

/**
 时间字符样式, 默认 "yyyy-MM-dd HH:mm:ss"
 */
@property (nonatomic, copy) NSString *qh_dateFormat;

/**
 显示选择视图

 @param sender 触发器
 */
- (void)qh_pickerViewShow:(id _Nullable )sender;

/**
 隐藏选择视图

 @param sender 触发器
 */
- (void)qh_pickerViewDismiss:(id _Nullable )sender;

@end

NS_ASSUME_NONNULL_END
