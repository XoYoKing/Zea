//
//  GQHProvinceModel.h
//  Xanthium
//
//  Created by GuanQinghao on 28/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"

@interface GQHProvinceModel : GQHBaseModel

/// 省编号
@property (nonatomic, copy) NSString *qh_provinceID;

/// 省名称
@property (nonatomic, copy) NSString *qh_provinceName;

/// 省经度
@property (nonatomic, assign) NSDecimalNumber *qh_provinceLongitude;

/// 省纬度
@property (nonatomic, assign) NSDecimalNumber *qh_provinceLatitude;


/// 获取省列表
+ (void)qh_fetchProvincesWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray *provinces, NSArray *provinceNames))success failure:(void(^)(NSError *error))failure;

@end
