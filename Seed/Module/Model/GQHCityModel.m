//
//  GQHCityModel.m
//  Xanthium
//
//  Created by GuanQinghao on 28/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHCityModel.h"
#import "GQHHeader.h"

@implementation GQHCityModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{
             @"qh_cityID" : @"id",
             @"qh_cityName" : @"placeNames",
             @"qh_cityLongitude" : @"longitude",
             @"qh_cityLatitude" : @"latitude"
             };
    //"id": "130100",
    //"placeNames": "石家庄市",
    //"longitude": 114.52208184420766,
    //"latitude": 38.048958314615454
}

/// 获取市列表
+ (void)qh_fetchCitiesWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *cities, NSArray *cityNames))success failure:(void(^)(NSError *error))failure {
    
}

@end
