//
//  AppDelegate+GQHIAP.h
//  Seed
//
//  Created by Mac on 2019/10/21.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate.h"
#import <StoreKit/StoreKit.h>

/**
 测试账号:admin@uter.top
 测试密码:@Bcd1234
 
 productID:
 top.uter.puzzle.aai
 top.uter.puzzle.ai
 */

NS_ASSUME_NONNULL_BEGIN

/**
 IAP(应用程序内购买)
 */
@interface AppDelegate (GQHIAP)

/**
 初始化IAP服务

 @param launchOptions 启动方式
 */
- (void)qh_IAPServerWithOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@protocol GQHIAPDelegate <NSObject>

@required

/// 获取商品列表
/// @param products 商品列表
/// @param code 返回码
/// @param info 返回信息
- (void)qh_fetchProducts:(NSArray *)products code:(NSInteger)code info:(NSDictionary *)info;

/// 发送App Store收据
/// @param file 本地文件路径
- (void)qh_sendAppStoreReceipt:(NSString *)file;

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

/// 请求商品列表
/// @param productID 商品ID
- (void)qh_fetchProductsWith:(NSString *)productID;

/// 商品支付
/// @param product 商品信息
- (void)qh_payForProduct:(SKProduct *)product;

@end

NS_ASSUME_NONNULL_END
