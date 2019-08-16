//
//  GQHCommonCell.h
//  Seed
//
//  Created by GuanQinghao on 03/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 纯文本 单行单列 SingleText
 */
@interface GQHCommonSingleTextCell : UITableViewCell

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(nullable id)data;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 纯文本 单行单列 SingleText
 */
@interface GQHCommonSingleInputTextCell : UITableViewCell

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(nullable id)data;

@end

NS_ASSUME_NONNULL_END



#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 纯文本 水平双文本 TextDoubleHorizontal
 */
@interface GQHCommonTextDoubleHorizontalCell : UITableViewCell

/**
 左文本框
 */
@property (nonatomic, strong) UILabel *qh_leftLabel;

/**
 右文本框
 */
@property (nonatomic, strong) UILabel *qh_rightLabel;

/**
 分割线
 */
@property (nonatomic, strong) UIView *qh_line;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 纯文本 垂直双文本 TextDoubleVertical
 */
@interface GQHCommonTextDoubleVerticalCell : UITableViewCell

/**
 上文本框
 */
@property (nonatomic, strong) UILabel *qh_upLabel;

/**
 下文本框
 */
@property (nonatomic, strong) UILabel *qh_downLabel;

/**
 分割线
 */
@property (nonatomic, strong) UIView *qh_line;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 单行输入框 单行双列 文本+输入框
 */
@interface GQHCommonInputTextDoubleHorizontalCell : UITableViewCell

/**
 左文本框
 */
@property (nonatomic, strong) UILabel *qh_leftLabel;

/**
 右单行输入框
 */
@property (nonatomic, strong) UITextField *qh_rightTextField;

/**
 分割线
 */
@property (nonatomic, strong) UIView *qh_line;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 多行输入框 双行单列多行输入框
 */
@interface GQHCommonInputTextDoubleVerticalCell : UITableViewCell

/**
 标题文本框
 */
@property (nonatomic, strong) UILabel *qh_titleLabel;

/**
 多行输入框
 */
@property (nonatomic, strong) UITextView *qh_contentTextView;

/**
 分割线
 */
@property (nonatomic, strong) UIView *qh_line;

@end

NS_ASSUME_NONNULL_END

/// 纯文字 三行单列
/// 纯文字 双行双列
/// 纯文字 三行双列
/// 图文 单行双列
/// 图文 单双行双列
/// 四个文本框
