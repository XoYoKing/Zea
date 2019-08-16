//
//  GQHNetworkError.m
//
//  Created by GuanQinghao on 2019-05-08.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHNetworkError.h"


@implementation GQHNetworkError

- (instancetype)initWithAFError:(NSError *)error info:(NSDictionary *)info {
    
    if (self = [super init]) {
        
        _qh_AFError = error;
        _qh_info = info;
        
        if (error) {
            
            // AFNetworking返回的错误信息
            _qh_code = @(error.code);
            _qh_message = error.domain;
            _qh_networkError = YES;
        } else {
            
            // 服务器返回的错误信息
            _qh_code = [info objectForKey:@"code"];
            _qh_message = info[@"msg"] ? : @"服务器未返回错误信息";
            _qh_networkError = NO;
        }
    }
    
    return self;
}

@end
