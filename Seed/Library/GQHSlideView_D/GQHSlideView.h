//
//  GQHSlideView.h
//  Seed
//
//  Created by GuanQinghao on 13/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, GQHPageControlAlignment) {
    
    GQHPageControlAlignmentLeft,       // 分页控件居左
    GQHPageControlAlignmentCenter,     // 分页控件居中
    GQHPageControlAlignmentRight,      // 分页控件居右
};

typedef NS_ENUM(NSUInteger, GQHPageControlStyle) {
    
    GQHPageControlStyleClassic,        // 系统自带经典样式
    GQHPageControlStyleAnimated,       // 动画效果
    GQHPageControlStyleNone,           // 无效果
};

@class GQHSlideView;
@protocol GQHSlideViewDelegate <NSObject>

@optional
/// 点击回调
- (void)qh_slideView:(GQHSlideView *)slideView didSelectItemAtIndex:(NSInteger)index;
/// 滚动回调
- (void)qh_slideView:(GQHSlideView *)slideView didScrollToIndex:(NSInteger)index;

/// 自定义轮播图cell类
- (Class)qh_customCollectionViewCellClassForSlideView:(GQHSlideView *)slideView;
/// 自定义轮播图cell的Nib
- (UINib *)qh_customCollectionViewCellNibForSlideView:(GQHSlideView *)slideView;
/// 自定义轮播图cell填充数据及其他设置
- (void)qh_setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index slideView:(GQHSlideView *)slideView;

@end


@interface GQHSlideView : UIView

/// 创建轮播图
+ (instancetype)qh_slideViewWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;
+ (instancetype)qh_slideViewWithFrame:(CGRect)frame imageURLArray:(NSArray *)imageURLArray;
+ (instancetype)qh_slideViewWithFrame:(CGRect)frame loop:(BOOL)endless imageArray:(NSArray *)imageArray;
+ (instancetype)qh_slideViewWithFrame:(CGRect)frame delegate:(id<GQHSlideViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;

/// 清除图片缓存
+ (void)qh_clearImageCache;

/// 滚动控制
- (void)qh_slideView:(GQHSlideView *)slideView scrollToIndex:(NSInteger)index;
- (void)qh_adjustWhenViewWillAppear;

/// 禁用手势
- (void)qh_disableScrollGesture;

/// 数据源
@property (nonatomic, strong) NSArray *qh_imageArray;// image or imageName or imagePath
@property (nonatomic, strong) NSArray *qh_imageURLArray;// imageURL or imageURLString
@property (nonatomic, strong) NSArray *qh_textArray;

#pragma mark 轮播属性
/// 自动轮播时间间隔
@property (nonatomic, assign) CGFloat qh_timeInterval;
/// 是否无限循环
@property (nonatomic, assign) BOOL qh_endless;
/// 是否自动轮播
@property (nonatomic, assign) BOOL qh_autoScroll;
/// 轮播滚动方向
@property (nonatomic, assign) UICollectionViewScrollDirection qh_scrollDirection;

/// 代理
@property (nonatomic, weak) id<GQHSlideViewDelegate> qh_delegate;

/// 点击监听
@property (nonatomic, copy) void (^selectItemMonitorBlock)(NSInteger index);
/// 滚动监听
@property (nonatomic, copy) void (^scrollToItemMonitorBlock)(NSInteger index);

/// 图片填充模式
@property (nonatomic, assign) UIViewContentMode qh_slideViewContentMode;
/// 占位图
@property (nonatomic, strong) UIImage *qh_placeholderImage;
/// 是否显示分页控件
@property (nonatomic, assign) BOOL qh_showPageControl;
/// 单页是否隐藏分页控件
@property (nonatomic, assign) BOOL qh_hidesForSinglePage;
/// 是否只显示文本内容
@property (nonatomic, assign) BOOL qh_onlyText;

#pragma mark 分页控件属性
/// 分页控件样式
@property (nonatomic, assign) GQHPageControlStyle qh_pageControlStyle;
/// 分页控件对齐方式
@property (nonatomic, assign) GQHPageControlAlignment qh_pageControlAlignment;

/// 分页控件左偏移量
@property (nonatomic, assign) CGFloat qh_pageControlOffsetLeft;
/// 分页控件右偏移量
@property (nonatomic, assign) CGFloat qh_pageControlOffsetRight;
/// 分页控件底部偏移量
@property (nonatomic, assign) CGFloat qh_pageControlOffsetBottom;
/// 分页控件点大小
@property (nonatomic, assign) CGSize qh_pageControlDotSize;

/// 分页控件点颜色
@property (nonatomic, strong) UIColor *qh_pageDotColor;
/// 分页控件当前页点颜色
@property (nonatomic, strong) UIColor *qh_currentPageDotColor;

/// 分页控件点图片
@property (nonatomic, strong) UIImage *qh_pageDotImage;
/// 分页控件当前页点图片
@property (nonatomic, strong) UIImage *qh_currentPageDotImage;

#pragma mark 文本框属性
/// 轮播图文本框文字颜色
@property (nonatomic, strong) UIColor *qh_titleLabelTextColor;
/// 轮播图文本框文字字体
@property (nonatomic, strong) UIFont *qh_titleLabelTextFont;
/// 轮播图文本框文字对齐方式
@property (nonatomic, assign) NSTextAlignment qh_titleLabelTextAlignment;
/// 轮播图文本框背景色
@property (nonatomic, strong) UIColor *qh_titleLabelBackgroundColor;
/// 轮播图文本框高度
@property (nonatomic, assign) CGFloat qh_titleLabelHeight;

@end
