//
//  UIBarButtonItem+GQHBadge.h
//  Seed
//
//  Created by Mac on 2019/2/27.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GQHBadgeViewProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (GQHBadge) <GQHBadgeViewProtocol>

#pragma mark - GQHBadgeViewProtocol
/**
 显示标识, 默认为红点模式, 无动画
 */
- (void)qh_showBadgeView;

/**
 显示标识
 
 @param style 消息标识视图样式
 @param animationType 消息标识视图动画样式
 */
- (void)qh_showBadgeViewWithStyle:(GQHBadgeViewStyle)style animationType:(GQHBadgeViewAnimationType)animationType;

/**
 移除标识
 */
- (void)qh_removeBadgeView;

@end

NS_ASSUME_NONNULL_END
