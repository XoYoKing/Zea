//
//  GQHIAPManager.h
//  Seed
//
//  Created by Mac on 2019/11/28.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

/// 内购支付结果码
typedef NS_ENUM(NSUInteger, GQHIAPResultCode) {
    
    GQHIAPResultCodePaymentOK,
    GQHIAPResultCodePaymentFailed,
    GQHIAPResultCodePaymentCancelled
};

/// 内购服务查询结果码
typedef NS_ENUM(NSUInteger, GQHIAPServiceCode) {
    
    GQHIAPServiceCodeUnavailable,
    GQHIAPServiceCodeProductsUnobtainable,
    GQHIAPServiceCodeProductsEmpty,
    GQHIAPServiceCodeProductsOK
};


NS_ASSUME_NONNULL_BEGIN

/// 内购代理
@protocol GQHIAPManagerDelegate <NSObject>

@required

/// 请求内购商品列表
/// @param code 查询结果码
/// @param content 查询结果
- (void)qh_fetchIAPProductsWithCode:(GQHIAPServiceCode)code content:(nullable id)content;

/// 交易失败
/// @param code 交易结果码
- (void)qh_failedIAPTransactionWithCode:(GQHIAPResultCode)code;

/// 发送内购交易收据到服务器(验证通过，删除收据，完成此次交易)
/// @param transaction 内购交易
/// @param file 收据文件路径
- (void)qh_sendIAPTransaction:(SKPaymentTransaction *)transaction receipt:(NSString *)file;

@optional

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface GQHIAPManager : NSObject

/**
 内购代理
 */
@property (nonatomic, weak) id<GQHIAPManagerDelegate> qh_delegate;

/// 内购管理器单例
+ (instancetype)qh_sharedIAPMannager;

/// 开始监听内购
- (void)qh_startMonitoringIAP;

/// 停止监听内购
- (void)qh_stopMonitoringIAP;

#pragma mark - 阶段一:请求商品列表
/// 请求商品信息
/// @param productIDs 商品ID数组(AppStore)
- (void)qh_fetchIAPProductsWith:(NSArray<NSString *> *)productIDs;

#pragma mark - 阶段二:内购支付
/// 内购支付
/// @param product 内购商品信息
- (void)qh_payForIAPProduct:(SKProduct *)product;

/// 收据验证成功, 完成交易并删除收据
/// @param transaction 本次交易
/// @param file 收据文件路径
- (void)qh_finishIAPTransaction:(SKPaymentTransaction *)transaction receipt:(NSString *)file;

/// 恢复内购交易
/// @param username 用户名
- (void)qh_restoreCompletedIAPTransactionsWithApplicationUsername:(NSString *)username;

@end

NS_ASSUME_NONNULL_END
