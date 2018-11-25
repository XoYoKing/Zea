//
//  GQHNetHelper.h
//  Xanthium
//
//  Created by GuanQinghao on 23/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "GQHMacro.h"


@class AFHTTPSessionManager;
@interface GQHNetHelper : NSObject

// 第三层 afnetworking get封装
+ (void)qh_requestGET:(NSString *)URLString parameters:(id)parameters success:(void(^)(NSNumber *code, NSString *message, NSDictionary *data))success failure:(void(^)(NSError *error))failure;

// 第三层 afnetworking post封装
+ (void)qh_requestPOST:(NSString *)URLString parameters:(id)parameters success:(void(^)(NSNumber *code, NSString *message, NSDictionary *data))success failure:(void(^)(NSError *error))failure;

@end
