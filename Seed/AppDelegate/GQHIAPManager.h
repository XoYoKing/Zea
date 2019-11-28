//
//  GQHIAPManager.h
//  Seed
//
//  Created by Mac on 2019/11/28.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


typedef NS_ENUM(NSUInteger, GQHIAPResultCode) {
    
    GQHIAPResultCodePaymentFailed,
    GQHIAPResultCodePaymentCancelled
};


typedef NS_ENUM(NSUInteger, GQHIAPServiceCode) {
    
    GQHIAPServiceCodeUnavailable,
    GQHIAPServiceCodeProductsUnobtainable,
    GQHIAPServiceCodeProductsEmpty,
    GQHIAPServiceCodeProductsOK
};


NS_ASSUME_NONNULL_BEGIN

@protocol GQHIAPDelegate <NSObject>

@required

/// 请求商品列表
/// @param code 返回码
/// @param content 返回内容
- (void)qh_fetchProductsWithCode:(GQHIAPServiceCode)code content:(nullable id)content;

/// 交易失败
/// @param code 交易失败码
- (void)qh_failedTransactionWithCode:(GQHIAPResultCode)code;

/// 发送App Store交易收据(验证通过，删除收据，完成此次交易)
/// @param transaction 本次交易
/// @param file 收据文件路径
- (void)qh_sendAppStoreTransaction:(SKPaymentTransaction *)transaction receipt:(NSString *)file;




@optional

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface GQHIAPManager : NSObject

/**
 内购代理
 */
@property (nonatomic, weak) id<GQHIAPDelegate> qh_delegate;

/// 内购管理器单例
+ (instancetype)qh_sharedIAPMannager;

/// 开始监听内购
- (void)qh_startMonitoringIAP;

/// 停止监听内购
- (void)qh_stopMonitoringIAP;

#pragma mark - 请求商品列表
/// 请求商品信息
/// @param productIDs 商品ID数组(AppStore)
- (void)qh_fetchProductsWith:(NSArray<NSString *> *)productIDs;

#pragma mark - 内购支付
/// 内购支付
/// @param product 内购商品信息
- (void)qh_payForProduct:(SKProduct *)product;

/// 收据验证成功, 完成交易并删除收据
/// @param transaction 本次交易
/// @param file 收据文件路径
- (void)qh_finishTransaction:(SKPaymentTransaction *)transaction receipt:(NSString *)file;

/// 恢复内购交易
/// @param username 用户名
- (void)qh_restoreCompletedTransactionsWithApplicationUsername:(NSString *)username;

@end

NS_ASSUME_NONNULL_END
