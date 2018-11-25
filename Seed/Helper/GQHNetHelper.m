
//
//  GQHNetHelper.m
//  Xanthium
//
//  Created by GuanQinghao on 23/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHNetHelper.h"

@implementation GQHNetHelper

+ (AFHTTPSessionManager *)shareManager {
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[AFHTTPSessionManager alloc] init];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
    });
    
    return manager;
}

// 第三层 afnetworking get封装
+ (void)qh_requestGET:(NSString *)URLString parameters:(id)parameters success:(void(^)(NSNumber *code, NSString *message, NSDictionary *data))success failure:(void(^)(NSError *error))failure {
    
    [[self shareManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"请求成功返回的数据内容:\n%@",responseObject);
        
        if (success) {
            
            NSNumber *responseCode = [responseObject objectForKey:@"code"];
            NSString *responseMessage = [responseObject objectForKey:@"msg"];
            NSDictionary *responseData = [responseObject objectForKey:@"data"];
            
            success(responseCode,responseMessage,responseData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
        }
    }];
}

// 第三层 afnetworking post封装
+ (void)qh_requestPOST:(NSString *)URLString parameters:(id)parameters success:(void(^)(NSNumber *code, NSString *message, NSDictionary *data))success failure:(void(^)(NSError *error))failure {
    
    [[self shareManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"请求成功返回的数据内容:\n%@",responseObject);
        
        if (success) {
            
            NSNumber *responseCode = [responseObject objectForKey:@"code"];
            NSString *responseMessage = [responseObject objectForKey:@"msg"];
            NSDictionary *responseData = [responseObject objectForKey:@"data"];
            
            success(responseCode,responseMessage,responseData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure) {
            
            failure(error);
        }
    }];
}

@end
