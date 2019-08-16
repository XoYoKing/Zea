//
//  GQHSinglePickerView.h
//  Seed
//
//  Created by Mac on 2018/12/17.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 单选视图回调

 @param index 选中对应的索引值
 @param selectedString 选中的值
 */
typedef void(^GQHSinglePickerViewSelectionBlock)(NSInteger index, NSString * _Nullable selectedString);


NS_ASSUME_NONNULL_BEGIN

@interface GQHSinglePickerView : UIView

/**
 单选视图回调
 */
@property (nonatomic, copy) GQHSinglePickerViewSelectionBlock _Nullable qh_block;

/**
 数据源
 */
@property (nonatomic, strong) NSArray <NSString *> *qh_dataSourceArray;

/**
 显示单选视图

 @param sender 触发器
 */
- (void)qh_pickerViewShow:(id _Nullable )sender;

/**
 隐藏单选视图

 @param sender 触发器
 */
- (void)qh_pickerViewDismiss:(id _Nullable )sender;

@end

NS_ASSUME_NONNULL_END
