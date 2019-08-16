//
//  UIDashLineView.h
//  Seed
//
//  Created by Mac on 2019/7/31.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface UIDashLineView : UIView

/**
 虚线宽度
 */
@property (nonatomic, assign) CGFloat dashLineWidth;

/**
 虚线颜色
 */
@property (nonatomic, strong) UIColor *dashLineColor;

/**
 虚线所有拐点
 */
@property (nonatomic, strong) NSArray *dashLines;

/**
 虚线样式
 */
@property (nonatomic, strong) NSArray *dashLineStyle;

@end

NS_ASSUME_NONNULL_END
