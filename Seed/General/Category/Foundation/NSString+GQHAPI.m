//
//  NSString+GQHAPI.m
//  Seed
//
//  Created by GuanQinghao on 21/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSString+GQHAPI.h"


@implementation NSString (GQHAPI)

/// 服务器地址
+ (nonnull NSString *)URLString {
    
    NSString *localURLString = @"http://192.168.199.244:8086";
    NSString *debugURLString = @"http://192.168.199.244:8088";
    NSString *releaseURLString = @"http://118.24.162.211:8088";
    NSString *domainURLString = @"http://yn.weate.net";
    
    return localURLString;
//    return debugURLString;
//    return releaseURLString;
//    return domainURLString;
}

#pragma mark URL地址
/// 图片地址
+ (nonnull NSString *)qh_imageURLString {
    
    return [[self URLString] stringByAppendingString:@"/attached/image/"];
}

/// 接口地址
+ (nonnull NSString *)qh_APIURLString {
    
    return [[self URLString] stringByAppendingString:@"/app"];
}

@end
