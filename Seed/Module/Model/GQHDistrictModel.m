//
//  GQHDistrictModel.m
//  Xanthium
//
//  Created by GuanQinghao on 28/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHDistrictModel.h"
#import "GQHHeader.h"

@implementation GQHDistrictModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{
             @"qh_districtID" : @"id",
             @"qh_districtName" : @"placeNames",
             @"qh_districtLongitude" : @"longitude",
             @"qh_districtLatitude" : @"latitude"
             };
    //"id": "420302",
    //"placeNames": "茅箭区",
    //"longitude": 110.7859526925799,
    //"latitude": 32.60560187019137
}

/// 获取县列表
+ (void)qh_fetchDistrictsWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *districts, NSArray *districtNames))success failure:(void(^)(NSError *error))failure {
    
}

@end
