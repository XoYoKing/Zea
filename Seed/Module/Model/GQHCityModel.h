//
//  GQHCityModel.h
//  Xanthium
//
//  Created by GuanQinghao on 28/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"

@interface GQHCityModel : GQHBaseModel

/// 市编号
@property (nonatomic, copy) NSString *qh_cityID;

/// 市名称
@property (nonatomic, copy) NSString *qh_cityName;

/// 市经度
@property (nonatomic, assign) NSDecimalNumber *qh_cityLongitude;

/// 市纬度
@property (nonatomic, assign) NSDecimalNumber *qh_cityLatitude;


/// 获取市列表
+ (void)qh_fetchCitiesWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *cities, NSArray *cityNames))success failure:(void(^)(NSError *error))failure;
@end
