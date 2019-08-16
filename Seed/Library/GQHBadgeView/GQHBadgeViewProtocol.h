//
//  GQHBadgeViewProtocol.h
//  Seed
//
//  Created by Mac on 2019/2/26.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//


#ifndef GQHBadgeViewProtocol_h
#define GQHBadgeViewProtocol_h


/**
 消息标识视图样式

 - GQHBadgeViewStyleRedDot: 红点样式
 - GQHBadgeViewStyleCounter: 计数样式
 - GQHBadgeViewStyleFixedText: 固定文本样式
 */
typedef NS_ENUM(NSUInteger, GQHBadgeViewStyle) {
    
    GQHBadgeViewStyleRedDot = 0,
    GQHBadgeViewStyleCounter,
    GQHBadgeViewStyleFixedText,
};


/**
 消息标识视图动画样式

 - GQHBadgeViewAnimationTypeNone: 无动画
 - GQHBadgeViewAnimationTypeShaked: 晃动动画类型
 - GQHBadgeViewAnimationTypeBouncing: 弹性动画类型
 - GQHBadgeViewAnimationTypeScaled: 缩放动画类型
 - GQHBadgeViewAnimationTypeBreathing: 呼吸动画类型
 */
typedef NS_ENUM(NSUInteger, GQHBadgeViewAnimationType) {
    
    GQHBadgeViewAnimationTypeNone = 0,
    GQHBadgeViewAnimationTypeShaked,
    GQHBadgeViewAnimationTypeBouncing,
    GQHBadgeViewAnimationTypeScaled,
    GQHBadgeViewAnimationTypeBreathing,
};


/**
 消息标识视图协议
 */
@protocol GQHBadgeViewProtocol <NSObject>

/**
 标识视图背景颜色
 */
@property (nonatomic, strong) UIColor *qh_badgeBackgroundColor;

/**
 标识字体
 */
@property (nonatomic, strong) UIFont *qh_badgeFont;

/**
 标识文字颜色
 */
@property (nonatomic, strong) UIColor *qh_badgeTextColor;

/**
 标识视图中心点偏移量
 */
@property (nonatomic, assign) CGPoint qh_badgeCenterOffset;

/**
 标识显示的数目
 */
@property (nonatomic, assign) NSInteger qh_badgeCount;

/**
 标识显示的固定文本
 */
@property (nonatomic, copy) NSString *qh_badgeFixedText;

/**
 标识显示的最大数目, 默认99
 */
@property (nonatomic, assign) NSInteger qh_badgeMaxNumber;

/**
 标识动画类型
 */
@property (nonatomic, assign) GQHBadgeViewAnimationType qh_badgeAnimationType;

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


#endif /* GQHBadgeViewProtocol_h */
