//
//  GQHCommonCell.h
//  Seed
//
//  Created by GuanQinghao on 03/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


/// 全局常量-通用Cell单倍外边距
UIKIT_EXTERN CGFloat const GQHCommonCellSingleMargin;
/// 全局常量-通用Cell双倍外边距
UIKIT_EXTERN CGFloat const GQHCommonCellDoubleMargin;


/// 纯文本 单行单列 TextSingle
@interface GQHCommonTextSingleCell : UITableViewCell

/// 文本框
@property (nonatomic, strong) UILabel *qh_textLabel;
/// 分割线
@property (nonatomic, strong) UIView *qh_separatorView;

@end


/// 纯文本 水平双文本 TextDoubleHorizontal
@interface GQHCommonTextDoubleHorizontalCell : UITableViewCell

/// 左文本框
@property (nonatomic, strong) UILabel *qh_leftLabel;
/// 右文本框
@property (nonatomic, strong) UILabel *qh_rightLabel;

@end


/// 纯文本 垂直双文本 TextDoubleVertical
@interface GQHCommonTextDoubleVerticalCell : UITableViewCell

/// 上文本框
@property (nonatomic, strong) UILabel *qh_upLabel;
/// 下文本框
@property (nonatomic, strong) UILabel *qh_downLabel;

@end


/// 纯文字 三行单列
/// 纯文字 双行双列
/// 纯文字 三行双列
/// 图文 单行双列
/// 图文 单双行双列
/// 四个文本框

