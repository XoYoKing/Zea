//
//  GQHProvinceModel.m
//  Xanthium
//
//  Created by GuanQinghao on 28/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHProvinceModel.h"
#import "GQHHeader.h"

@implementation GQHProvinceModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{
             @"qh_provinceID" : @"id",
             @"qh_provinceName" : @"placeNames",
             @"qh_provinceLongitude" : @"longitude",
             @"qh_provinceLatitude" : @"latitude"
             };
    //"id": "110000",
    //"placeNames": "北京市",
    //"longitude": 116.39564503787867,
    //"latitude": 39.92998577808024
}

/// 获取省列表
+ (void)qh_fetchProvincesWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *provinces, NSArray *provinceNames))success failure:(void(^)(NSError *error))failure {
    
}

@end
