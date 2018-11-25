//
//  GQHSlideView.h
//  Seed
//
//  Created by GuanQinghao on 13/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GQHSlideView;
@protocol GQHSlideViewDelegate <NSObject>

@required

@optional
/// 点击回调
- (void)qh_slideView:(GQHSlideView *)slideView didSelectItemAtIndex:(NSInteger)index;
/// 滚动回调
- (void)qh_slideView:(GQHSlideView *)slideView didScrollToIndex:(NSInteger)index;

@end


@interface GQHSlideView : UIView

/// 代理
@property (nonatomic, weak) id<GQHSlideViewDelegate> qh_delegate;

/// 数据源
@property (nonatomic, strong) NSArray *qh_imageArray;// image or imageName or imagePath
@property (nonatomic, strong) NSArray *qh_imageURLArray;// imageURL or imageURLString
@property (nonatomic, strong) NSArray *qh_textArray;

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame duration:(NSTimeInterval)duration;

#pragma mark 轮播属性
/// 是否只显示文本内容
@property (nonatomic, assign) BOOL qh_onlyText;
/// 是否显示分页控件
@property (nonatomic, assign) BOOL qh_showPageControl;
/// 单页是否隐藏分页控件
@property (nonatomic, assign) BOOL qh_hidesForSinglePage;
/// 图片填充模式
@property (nonatomic, assign) UIViewContentMode qh_slideViewContentMode;
/// 轮播滚动方向
@property (nonatomic, assign) UICollectionViewScrollDirection qh_scrollDirection;

#pragma mark 分页控件属性
/// 分页控件点颜色
@property (nonatomic, strong) UIColor *qh_pageDotColor;
/// 分页控件当前页点颜色
@property (nonatomic, strong) UIColor *qh_currentPageDotColor;

#pragma mark 文本框属性
/// 轮播图文本框高度
@property (nonatomic, assign) CGFloat qh_textLabelHeight;
/// 轮播图文本框文字字体
@property (nonatomic, strong) UIFont *qh_textLabelTextFont;
/// 轮播图文本框文字颜色
@property (nonatomic, strong) UIColor *qh_textLabelTextColor;
/// 轮播图文本框背景色
@property (nonatomic, strong) UIColor *qh_textLabelBackgroundColor;
/// 轮播图文本框文字对齐方式
@property (nonatomic, assign) NSTextAlignment qh_textLabelTextAlignment;

@end
