//
//  UIPaddingLabel.h
//  Seed
//
//  Created by Mac on 2019/7/31.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/// xib可预览效果
IB_DESIGNABLE

@interface UIPaddingLabel : UILabel

/**
 文本框内边距, 默认 UIEdgeInsetsZero
 */
@property (nonatomic, assign) UIEdgeInsets padding;


/**
 文本框上内边距, xib属性, 默认0
 */
@property (nonatomic, assign) IBInspectable CGFloat topPadding;

/**
 文本框下内边距, xib属性, 默认0
 */
@property (nonatomic, assign) IBInspectable CGFloat bottomPadding;


/**
 文本框左内边距, xib属性, 默认0
 */
@property (nonatomic, assign) IBInspectable CGFloat leftPadding;

/**
 文本框右内边距, xib属性, 默认0
 */
@property (nonatomic, assign) IBInspectable CGFloat rightPadding;

@end

NS_ASSUME_NONNULL_END
