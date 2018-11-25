//
//  GQHOrderModel.h
//  Xanthium
//
//  Created by GuanQinghao on 23/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


@interface GQHOrderModel : GQHBaseModel

/// 订单ID
@property (nonatomic, copy) NSString *qh_orderID;
/// 订单编号
@property (nonatomic, copy) NSString *qh_orderNumber;

/// 确认装车(司机)
@property (nonatomic, copy) NSString *qh_driverLoadedTime;
/// 确认送达(司机)
@property (nonatomic, copy) NSString *qh_driverUnloadedTime;
/// 确认协议(司机)
@property (nonatomic, copy) NSString *qh_driverContractTime;
/// 确认收货(货主)
@property (nonatomic, copy) NSString *qh_ownerUnloadedTime;
/// 取消时间
@property (nonatomic, copy) NSString *qh_cancelTime;
/// 订单状态
@property (nonatomic, copy) NSString *qh_orderState;
/// 评价状态
@property (nonatomic, copy) NSString *qh_orderReviewState;// 货主评价司机
/// 评价状态
@property (nonatomic, copy) NSString *qh_orderReviewedState;// 司机评价货主
/// 开票状态
@property (nonatomic, copy) NSString *qh_invoiceState;
/// 附件
@property (nonatomic, copy) NSString *qh_attachment;
/// 大文本ID
@property (nonatomic, copy) NSString *qh_largeTextID;

/// 协议ID
@property (nonatomic, copy) NSString *qh_contractID;
/// 报价ID
@property (nonatomic, copy) NSString *qh_qutationID;
/// 公里数
@property (nonatomic, assign) CGFloat qh_mileage;
/// 货物重量
@property (nonatomic, assign) CGFloat qh_freightWeight;
/// 收货人
@property (nonatomic, copy) NSString *qh_consignee;
/// 收货人电话
@property (nonatomic, copy) NSString *qh_consigneeMobile;
/// 收货时间
@property (nonatomic, copy) NSString *qh_consigningTime;

/// 预付款
@property (nonatomic, copy) NSString *qh_contractPrepaymentSum;
/// 尾款
@property (nonatomic, copy) NSString *qh_contractFinalPaymentSum;
/// 其他费用
@property (nonatomic, copy) NSString *qh_contractOtherExpenseSum;
/// 总金额
@property (nonatomic, copy) NSString *qh_amount;

/// 货源ID
@property (nonatomic, copy) NSString *qh_freightID;
/// 起始地行政编码
@property (nonatomic, copy) NSString *qh_departureID;
/// 起始地经度
@property (nonatomic, copy) NSString *qh_departureLatitude;
/// 起始地纬度
@property (nonatomic, copy) NSString *qh_departureLongitude;
/// 起始地
@property (nonatomic, copy) NSString *qh_departure;
/// 目的地行政编码
@property (nonatomic, copy) NSString *qh_destinationID;
/// 目的地经度
@property (nonatomic, copy) NSString *qh_destinationLatitude;
/// 目的地纬度
@property (nonatomic, copy) NSString *qh_destinationLongitude;
/// 目的地
@property (nonatomic, copy) NSString *qh_destination;
/// 货源需求车型
@property (nonatomic, copy) NSString *qh_modelWanted;
/// 货源需求车长
@property (nonatomic, copy) NSString *qh_lengthWanted;
/// 装车时间
@property (nonatomic, copy) NSString *qh_loadingTime;
/// 货物类型
@property (nonatomic, copy) NSString *qh_freightType;
/// 货物类型编码
@property (nonatomic, copy) NSString *qh_freightTypeCode;

/// 司机ID
@property (nonatomic, copy) NSString *qh_driverID;
/// 司机姓名
@property (nonatomic, copy) NSString *qh_driverName;
/// 司机头像
@property (nonatomic, copy) NSString *qh_driverAvatar;
/// 司机手机号
@property (nonatomic, copy) NSString *qh_driverMobile;
/// 司机评分
@property (nonatomic, assign) CGFloat qh_driverScore;
/// 车型编码
@property (nonatomic, copy) NSString *qh_modelCode;
/// 车型
@property (nonatomic, copy) NSString *qh_model;
/// 车辆标准车长
@property (nonatomic, copy) NSString *qh_normalLength;
/// 车辆标准载重
@property (nonatomic, copy) NSString *qh_normalLoading;
/// 车牌号
@property (nonatomic, copy) NSString *qh_licensePlateNumber;


///  获取货源列表
+ (void)qh_fetchOrdersWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray<GQHOrderModel *> *orders))success failure:(void(^)(NSError *error))failure;

///  获取订单详情
+ (void)qh_fetchOrderDetailWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHOrderModel *order))success failure:(void(^)(NSError *error))failure;

@end
