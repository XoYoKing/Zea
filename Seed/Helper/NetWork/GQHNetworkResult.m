//
//  GQHNetworkResult.m
//
//  Created by GuanQinghao on 2019-05-08.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHNetworkResult.h"
#import "GQHNetworkError.h"


@implementation GQHNetworkResult

- (instancetype)initWithSuccessResponse:(NSDictionary *)response {
    
    if (self = [super init]) {
        
        _qh_status = YES;
        _qh_code = response[@"code"];
        _qh_message = response[@"msg"];
        _qh_data = response[@"data"];
        _qh_response = response;
    }
    
    return self;
}

- (instancetype)initWithError:(GQHNetworkError *)error {
    
    if (self = [super init]) {
        
        _qh_status = NO;
        _qh_code = error.qh_code;
        _qh_message = error.qh_message;
        _qh_error = error;
        _qh_response = error.qh_info;
    }
    
    return self;
}

@end
