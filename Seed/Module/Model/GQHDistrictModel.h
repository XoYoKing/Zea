//
//  GQHDistrictModel.h
//  Xanthium
//
//  Created by GuanQinghao on 28/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"

@interface GQHDistrictModel : GQHBaseModel

/// 县编号
@property (nonatomic, copy) NSString *qh_districtID;

/// 县名称
@property (nonatomic, copy) NSString *qh_districtName;

/// 县经度
@property (nonatomic, assign) NSDecimalNumber *qh_districtLongitude;

/// 县纬度
@property (nonatomic, assign) NSDecimalNumber *qh_districtLatitude;

/// 获取县列表
+ (void)qh_fetchDistrictsWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *districts, NSArray *districtNames))success failure:(void(^)(NSError *error))failure;

@end
