//
//  GQHIAPManager.m
//  Seed
//
//  Created by Mac on 2019/11/28.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHIAPManager.h"


/// 收据Key
static NSString * const iap_receipt_key = @"iap_receipt_key";
/// 日期Key
static NSString * const iap_date_key = @"iap_date_key";
/// 用户Key
static NSString * const iap_user_id_key = @"iap_user_id_key";
/// 商品Key
static NSString * const iap_product_id_key = @"iap_product_id_key";


/// 内购队列
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
 请求是否完成(避免重复请求)
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
    NSLog(@"%s",__func__);
    
    dispatch_async(iap_queue(), ^{
        
        self.finish = YES;
        
        /**
         内购过程:
         0.向苹果服务器发送请求, 查询商品列表
         1.根据商品信息发起内购支付或恢复内购
         2.内购成功返回内购收据, 向公司服务器发送收据进行验证
         3.公司服务器向苹果服务器验证收据
         4.收据验证结束, 完成交易, 删除本地收据
         */
        
        // 应用程序启动时监听内购
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    });
}

/// 停止监听内购
- (void)qh_stopMonitoringIAP {
    NSLog(@"%s",__func__);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 应用程序启动时移除监听
        [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    });
}


#pragma mark - 阶段一:请求商品列表
/// 请求商品信息
/// @param productIDs 商品ID数组(AppStore)
- (void)qh_fetchIAPProductsWith:(NSArray<NSString *> *)productIDs {
    NSLog(@"%s",__func__);
    
    if (self.finish) {
        
        //MARK:用户是否允许内购
        if ([SKPaymentQueue canMakePayments]) {
            
            if (productIDs.count > 0) {
                
                // 请求开始
                self.finish = NO;
                
                NSSet *set = [NSSet setWithArray:productIDs];
                SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
                request.delegate = self;
                [request start];
            } else {
                
                // 商品ID为空
                if ([self.qh_delegate respondsToSelector:@selector(qh_fetchIAPProductsWithCode:content:)]) {
                    
                    [self.qh_delegate qh_fetchIAPProductsWithCode:GQHIAPServiceCodeProductsEmpty content:nil];
                }
                
                // 请求完成
                self.finish = YES;
            }
        } else {
            
            if ([self.qh_delegate respondsToSelector:@selector(qh_fetchIAPProductsWithCode:content:)]) {
                
                // 内购不可用
                [self.qh_delegate qh_fetchIAPProductsWithCode:GQHIAPServiceCodeUnavailable content:nil];
            }
            
            // 请求完成
            self.finish = YES;
        }
    }
}

#pragma mark - SKProductsRequestDelegate
/// 收到商品列表查询请求响应
/// @param request 发送的商品列表查询请求
/// @param response 收到的响应
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"%s",__func__);
    
    // 请求完成
    self.finish = YES;
    
    // 商品列表
    NSArray<SKProduct *> *products = response.products;
    
    if (products.count > 0) {
        
        if ([self.qh_delegate respondsToSelector:@selector(qh_fetchIAPProductsWithCode:content:)]) {
            
            [self.qh_delegate qh_fetchIAPProductsWithCode:GQHIAPServiceCodeProductsOK content:products];
        }
    } else {
        
        // 商品列表为空
        if ([self.qh_delegate respondsToSelector:@selector(qh_fetchIAPProductsWithCode:content:)]) {
            
            [self.qh_delegate qh_fetchIAPProductsWithCode:GQHIAPServiceCodeProductsEmpty content:nil];
        }
    }
}

/// 查询商品列表失败
/// @param request 发送的商品列表查询请求
/// @param error 错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%s",__func__);
    
    // 请求完成
    self.finish = YES;
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_fetchIAPProductsWithCode:content:)]) {
        
        [self.qh_delegate qh_fetchIAPProductsWithCode:GQHIAPServiceCodeProductsUnobtainable content:nil];
    }
}


#pragma mark - 阶段二:内购支付
/// 内购支付
/// @param product 内购商品信息
- (void)qh_payForIAPProduct:(SKProduct *)product {
    NSLog(@"%s",__func__);
    
    if (self.finish) {
        
        // 请求开始
        self.finish = NO;
        
        // 发起购买请求
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

/// 恢复内购交易
/// @param username 用户名
- (void)qh_restoreCompletedIAPTransactionsWithApplicationUsername:(NSString *)username {
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactionsWithApplicationUsername:username];
}

/// 收据验证成功, 完成交易并删除收据
/// @param transaction 本次交易
/// @param file 收据文件路径
- (void)qh_finishIAPTransaction:(SKPaymentTransaction *)transaction receipt:(NSString *)file {
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    self.finish = YES;
    
    NSFileManager *fileManager =[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:file]) {
        
        [fileManager removeItemAtPath:file error:nil];
    }
}

#pragma mark - SKPaymentTransactionObserver
/// 更新内购队列交易信息
/// @param queue 内购队列
/// @param transactions 交易信息
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    NSLog(@"%s",__func__);
    
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchasing: {
                
                //TODO:正在交易
            }
                break;
            case SKPaymentTransactionStatePurchased: {
                
                // 交易完成
                [self updateIAPTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateFailed: {
                
                // 交易失败
                [self failedTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateRestored: {
                
                //恢复内购
                [self updateIAPTransaction:transaction];
            }
                break;
                
            case SKPaymentTransactionStateDeferred: {
                
                //TODO:推迟交易
            }
                break;
        }
    }
}

/// 更新内购交易
/// @param transaction 内购交易
- (void)updateIAPTransaction:(SKPaymentTransaction *)transaction {
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_sendIAPTransaction:receipt:)]) {
        
        // 获取交易收据
        [self fetchTransactionReceipt:transaction];
        // 保存交易收据
        [self saveTransactionReceipt:transaction];
        // 验证交易收据
        [self verifyTransactionReceipt:transaction];
    }
}

/// 获取交易收据
/// @param transaction 内购交易
- (void)fetchTransactionReceipt:(SKPaymentTransaction *)transaction {
    NSLog(@"%s",__func__);
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    self.receipt = [receiptData base64EncodedStringWithOptions:0];
}

/// 持久化保存交易收据
/// @param transaction 本次交易
- (void)saveTransactionReceipt:(SKPaymentTransaction *)transaction {
    NSLog(@"%s",__func__);
    
    // 购买的东西
    NSString *productID = transaction.payment.productIdentifier;
    
    // 购买的日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.date = [dateFormatter stringFromDate:transaction.transactionDate];
    
    // 收据文件保存路径
    NSString *filePath = [NSString stringWithFormat:@"%@/%@_%@.plist",[self receiptdiDirectoryPath] ,productID ,self.date];
    
    // 收据保存本地
    if (self.receipt) {
        
        NSMutableDictionary *receipt = [NSMutableDictionary dictionary];
        [receipt setObject:productID forKey:iap_product_id_key];
        [receipt setObject:self.date forKey:iap_date_key];
        if (self.receipt) {
            [receipt setObject:self.receipt forKey:iap_receipt_key];
        }
        
        [receipt writeToFile:filePath atomically:YES] ? NSLog(@"保存成功") : NSLog(@"保存失败");
    }
}

/// 验证交易收据
/// @param transaction 本次交易
- (void)verifyTransactionReceipt:(SKPaymentTransaction *)transaction {
    NSLog(@"%s",__func__);
    
    // 收据文件夹
    NSString *directory = [self receiptdiDirectoryPath];
    // 所有收据
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directory error:nil];
    
    for (NSString *name in files) {
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",directory,name];
        NSLog(@"%@",filePath);
        
        [self.qh_delegate qh_sendIAPTransaction:transaction receipt:filePath];
    }
}

/// 内购交易失败
/// @param transaction 交易
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"%s",__func__);
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_failedIAPTransactionWithCode:)]) {
        
        if (transaction.error.code == SKErrorPaymentCancelled) {
            
            [self.qh_delegate qh_failedIAPTransactionWithCode:GQHIAPResultCodePaymentCancelled];
        } else {
            
            [self.qh_delegate qh_failedIAPTransactionWithCode:GQHIAPResultCodePaymentFailed];
        }
    }
    
    // 交易结束
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    self.finish = YES;
}

/// 保存收据文件夹路径
- (NSString *)receiptdiDirectoryPath {
    
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    // 创建iap文件夹
    NSString *directory = [documentsPath stringByAppendingPathComponent:@"iap"];
    
    BOOL isDirectory = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:&isDirectory];
    
    if (!(isDirectory == YES && existed == YES)) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return directory;
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
