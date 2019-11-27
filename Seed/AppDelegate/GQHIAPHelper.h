//
//  GQHIAPHelper.h
//  Seed
//
//  Created by Mac on 2019/11/27.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GQHIAPResultCode) {
    
    GQHIAPResultCodeUnknown,
    GQHIAPResultCodePaymentFailed,
    GQHIAPResultCodePaymentCancelled
};


typedef NS_ENUM(NSUInteger, GQHIAPServiceCode) {
    
    GQHIAPServiceCodeUnknown,
    GQHIAPServiceCodeUnsupport,
    GQHIAPServiceCodeUnavailable,
    GQHIAPServiceCodeProductsUnobtainable,
    GQHIAPServiceCodeProductsEmpty,
    GQHIAPServiceCodeProductsOK
};




@protocol GQHIAPDelegate <NSObject>

@required

/// 获取商品列表
/// @param code 返回码
/// @param content 返回内容
- (void)qh_fetchProductsWithCode:(GQHIAPServiceCode)code content:(nullable id)content;




/// 发送App Store收据
/// @param file 本地文件路径
- (void)qh_sendAppStoreReceipt:(NSString *)file;

@optional

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface GQHIAPHelper : NSObject

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

/// 请求商品信息
/// @param productIDs 商品ID数组(AppStore)
- (void)qh_fetchProductsWith:(NSArray<NSString *> *)productIDs;

/// 商品支付
/// @param product 商品信息
- (void)qh_payForProduct:(SKProduct *)product;

@end

NS_ASSUME_NONNULL_END
