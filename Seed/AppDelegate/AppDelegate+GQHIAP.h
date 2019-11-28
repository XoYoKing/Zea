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
