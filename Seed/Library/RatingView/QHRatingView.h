//
//  QHRatingView.h
//  
//
//  Created by GuanQinghao on 26/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QHRatingView : UIView

/** 图片说明 **
 默认      default
 5 分      greatest
 3 ~ 4 分  greater
 1 ~ 2 分  normal
 0 分      awful
 */

// 评分 worst 为 YES 时 0 ~ 5; worst 为 NO 时 1 ~ 5;
@property (nonatomic, assign, readonly) NSInteger ratingValue;

// 评分是否包括 0 分
@property (nonatomic, assign, ) BOOL worst;

+ (instancetype)ratingViewWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame;

@end
