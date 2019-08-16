//
//  GQHLockView.h
//  SSGestureLockView
//
//  Created by Mac on 2018/10/18.
//  Copyright © 2018 ThisRhythm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GQHLockView;


/**
 手势解锁视图代理
 */
@protocol GQHLockViewDelegate <NSObject>

@required

@optional
/**
 手势解锁(获取value 判断后设置qh_show)

 @param lockView 手势解锁视图
 @param value 解锁值
 */
- (void)qh_lockView:(GQHLockView *)lockView value:(NSString *)value;

@end


NS_ASSUME_NONNULL_BEGIN

@interface GQHLockView : UIView

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHLockViewDelegate> qh_delegate;

/**
 是否显示解锁错误
 */
@property (nonatomic, assign) BOOL qh_show;

@end

NS_ASSUME_NONNULL_END
