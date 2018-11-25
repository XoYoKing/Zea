//
//  UIFont+GQHFont.h
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIFont (GQHFont)

/// 最小字体 小字
@property (nonatomic, readonly, class) UIFont *qh_smallestFont;
/// 副文、列表副文
@property (nonatomic, readonly, class) UIFont *qh_smallerFont;
/// 正文、列表正文
@property (nonatomic, readonly, class) UIFont *qh_defaultFont;
/// 标题、按钮
@property (nonatomic, readonly, class) UIFont *qh_biggerFont;
/// 最大字体 导航、突出内容
@property (nonatomic, readonly, class) UIFont *qh_biggestFont;

@end
