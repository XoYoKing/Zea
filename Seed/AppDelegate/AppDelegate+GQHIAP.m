//
//  AppDelegate+GQHIAP.m
//  Seed
//
//  Created by Mac on 2019/10/21.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate+GQHIAP.h"

@implementation AppDelegate (GQHIAP)

/**
 初始化IAP服务
 
 @param launchOptions 启动方式
 */
- (void)qh_IAPServerWithOptions:(NSDictionary *)launchOptions {
    
    // 应用程序启动完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLaunch:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    // 应用程序将要被终止
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:UIApplicationWillTerminateNotification object:nil];
}

/**
 启动内购服务

 @param notification 应用程序启动通知
 */
- (void)didLaunch:(NSNotification *)notification {
    
    [[GQHIAPManager qh_sharedIAPMannager] qh_startMonitoringIAP];
}

/**
 停止内购服务

 @param notification 应用程序被终止通知
 */
- (void)willTerminate:(NSNotification *)notification {
    
    [[GQHIAPManager qh_sharedIAPMannager] qh_stopMonitoringIAP];
}

@end






/// 收据Key
static NSString * const receipt_key = @"receipt_key";
/// 日期Key
static NSString * const date_key = @"date_key";
/// 用户Key
static NSString * const user_id_key = @"user_id_key";

dispatch_queue_t iap_queue() {
    
    static dispatch_queue_t as_iap_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        as_iap_queue = dispatch_queue_create("top.uter.puzzle.iap.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return as_iap_queue;
}

@interface GQHIAPManager () <SKPaymentTransactionObserver, SKProductsRequestDelegate>

/**
 交易成功后拿到一个BASE64编码字符串, 表示交易收据
 */
@property (nonatomic, copy) NSString *receipt;

/**
 交易日期
 */
@property (nonatomic, copy) NSString *date;

/**
 交易人
 */
@property (nonatomic, copy) NSString *userID;

/**
 请求商品是否完成
 */
@property (nonatomic, assign) BOOL finish;

@end

/// 内购管理器单例
static GQHIAPManager *manager = nil;

@implementation GQHIAPManager

/// 内购管理器单例
+ (instancetype)qh_sharedIAPMannager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[super allocWithZone:NULL] init];
    });
    
    return manager;
}

- (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    return  [[self class] qh_sharedIAPMannager];
}

/// 开始监听内购
- (void)qh_startMonitoringIAP {
    
    dispatch_async(iap_queue(), ^{
        
        self.finish = YES;
        
        /**
         内购两个阶段:
         阶段一:
         第一步, 向苹果服务器请求商品列表
         第二步, 根据商品信息支付费用, 支付成功后返回凭证
         
         阶段二:
         第一步, 应用程序向公司服务器发送凭证验证
         第二步, 公司服务器向苹果服务器凭证验证
         */
        
        /**
         阶段一场景:
         应用程序启动时监听是否有未完成的订单
         */
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

        /**
         阶段二场景:
         应用程序启动时检测本地是否有未验证的receipt文件
         */
        [self verifyReceiptFile];
    });
}

/// 停止监听内购
- (void)qh_stopMonitoringIAP {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    });
}

/// 请求商品信息
/// @param productID 商品ID(AppStore)
- (void)qh_fetchProductsWith:(NSString *)productID {
    
    if (self.finish) {
        
        if ([SKPaymentQueue canMakePayments]) {
            
            //MARK: 用户授权允许内购
            
            if (productID.length > 0) {
                
                self.finish = NO;
                
                //TODO:字符串集合
                NSSet *set = [NSSet setWithObject:productID];
                SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
                request.delegate = self;
                [request start];
            } else {
                
                NSLog(@"App Store 商品ID为空");
                //TODO: 商品为空
                
                self.finish = YES;
            }
        } else {
            
            //TODO:没有权限
            
            self.finish = YES;
        }
    } else {
        
        NSLog(@"还有未完成的订单");
    }
}

#pragma mark - SKProductsRequestDelegate

/// 收到商品列表查询请求响应
/// @param request 发送的商品列表查询请求
/// @param response 收到的响应
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    // 商品列表 - 对一个productID有多个商品
    NSArray<SKProduct *> *products = response.products;
    
    
    //TODO: 商品列表查询处理
    if (products.count > 0) {
        
        if ([self.qh_delegate respondsToSelector:@selector(qh_fetchProducts:code:info:)]) {
            
            [self.qh_delegate qh_fetchProducts:products code:1 info:@{}];
        }
    } else {
        
        NSLog(@"无法获取商品信息或商品列表为空");
        
        self.finish = YES;
    }
}

/// 查询商品列表失败
/// @param request 发送的商品列表查询请求
/// @param error 错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"商品查询失败");
    //TODO:失败
    
    self.finish = YES;
}

/// 内购支付
/// @param product 内购商品信息
- (void)qh_payForProduct:(SKProduct *)product {
    
    // 发起购买请求
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

/// 验证成功后移除购买凭证
- (void)removeReceiptFileAtPath:(NSString *)filePath {
    
    NSFileManager *fileManager =[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

#pragma mark - SKPaymentTransactionObserver

/// 更新内购队列交易信息
/// @param queue 内购队列
/// @param transactions 交易信息
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchasing: {
                
                // 正在交易
                //TODO:支付？？
            }
                break;
            case SKPaymentTransactionStatePurchased: {
                
                // 交易完成
                // 0.获取收据
                [self fetchReceiptFile];
                
                // 1.持久化保存收据 -> Documents/iap/name.plist
                [self saveReceiptFile];
                
                // 2.验证收据
                [self verifyReceiptFile];
                
                // 3.结束交易
                [self finishTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateFailed: {
                
                // 交易失败
                [self failedTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateRestored: {
                
                // 恢复已购买过的交易
                [self restoreTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateDeferred: {
                
                // 推迟交易
                //TODO:？
            }
                break;
        }
    }
}

#pragma mark - PrivateMethod

/// 完成内购交易
/// @param transaction 交易
- (void)finishTransaction:(SKPaymentTransaction *)transaction {
    
    self.finish = YES;
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

/// 内购交易失败
/// @param transaction 交易
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"交易失败, transaction.error.code = %d",transaction.error.code);
    
    if (transaction.error.code == SKErrorPaymentCancelled) {
        
        // 用户取消
        //TODO:cancelled
    } else {
        
        // 内购支付失败
        //TODO:failed
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    self.finish = YES;
}

/// 恢复内购交易
/// @param transaction 交易
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    self.finish = YES;
}

#pragma mark receipt
/// 获取购买凭证
- (void)fetchReceiptFile {
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    self.receipt = [receiptData base64EncodedStringWithOptions:0];
}

/// 保存购买凭证
- (void)saveReceiptFile {
    
    // 购买日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.date = [dateFormatter stringFromDate: [NSDate date]];
    
    // 用户ID
    self.userID = @"UserID";
    
    // 收据文件保存路径
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist",[self receiptdiDirectoryPath] ,self.date];
    
    // 本地文件内容
    NSDictionary *receipt = @{receipt_key:self.receipt,
                              date_key:self.date,
                              user_id_key:self.userID};
    
    [receipt writeToFile:filePath atomically:YES];
}

/// 验证购买凭证
- (void)verifyReceiptFile {
    
    // 收据文件夹
    NSString *directory = [self receiptdiDirectoryPath];
    // 所有凭据
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:nil];
    
    for (NSString *name in files) {
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.plist",directory,name];
        
        //TODO:delegate
        [self sendAppStoreRequest:filePath];
    }
}

- (void)sendAppStoreRequest:(NSString *)file {
    
    NSDictionary *receipt = [NSDictionary dictionaryWithContentsOfFile:file];
    
    //TODO:与后台交互
}

/// 保存收据文件夹路径
- (NSString *)receiptdiDirectoryPath {
    
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return [NSString stringWithFormat:@"%@/iap",documentPath];
}

/// UUID替代方法
+ (NSString *)uniqueString {
    
    CFUUIDRef UUIDRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef UUID = CFUUIDCreateString(kCFAllocatorDefault, UUIDRef);
    NSString *result = (__bridge NSString *)UUID;
    
    CFRelease(UUIDRef);
    CFRelease(UUID);
    
    return result;
}

@end
