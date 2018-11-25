//
//  GQHSliderImageView.h
//  Seed
//
//  Created by GuanQinghao on 04/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GQHSliderImageViewDelegate <NSObject>

@required

@optional
/// 滑动滑块
- (void)qh_slide:(UIImageView *)imageView;

@end


@interface GQHSliderImageView : UIImageView

/// 有效性
@property (nonatomic, assign) BOOL qh_valid;
/// 代理
@property (nonatomic, weak) id<GQHSliderImageViewDelegate> qh_delegate;

@end



