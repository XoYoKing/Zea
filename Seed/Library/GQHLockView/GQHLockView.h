//
//  GQHLockView.h
//  SSGestureLockView
//
//  Created by Mac on 2018/10/18.
//  Copyright © 2018 ThisRhythm. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GQHLockView;
@protocol GQHLockViewDelegate <NSObject>

@required

@optional
/// 手势解锁代理(获取value 判断后设置qh_show)
- (void)qh_lockView:(GQHLockView *)lockView value:(NSString *)value;

@end


@interface GQHLockView : UIView

/// 代理
@property (nonatomic, weak) id<GQHLockViewDelegate> qh_delegate;
/// 解锁错误结果是否显示
@property (nonatomic, assign) BOOL qh_show;

@end
