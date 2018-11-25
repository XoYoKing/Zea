//
//  GQHOrderModel.m
//  Xanthium
//
//  Created by GuanQinghao on 23/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHOrderModel.h"
#import "GQHHeader.h"

@implementation GQHOrderModel

/// 模型字段映射
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{
             @"qh_orderID" : @"id",
             @"qh_orderNumber" : @"waybillAwb",
             @"qh_driverLoadedTime" : @"confirmLoadTime",
             @"qh_driverUnloadedTime" : @"confirmUnloadTime",
             @"qh_driverContractTime" : @"affProTime",
             @"qh_ownerUnloadedTime" : @"shiComTime",
             @"qh_cancelTime" : @"cancelTime",
             @"qh_orderState" : @"waybillState",
             @"qh_orderReviewState" : @"evaluateState",
             @"qh_orderReviewedState" : @"reviewedState",
             @"qh_invoiceState" : @"invoiceStatus",
             @"qh_attachment" : @"attachment",
             @"qh_largeTextID" : @"largeTextId",
             
             @"qh_contractID" : @"waybillAgId",
             @"qh_qutationID" : @"quotationId",
             @"qh_mileage" : @"mileage",
             @"qh_freightWeight" : @"demandVehicle",
             @"qh_consignee" : @"consignee",
             @"qh_consigneeMobile" : @"consigneePhone",
             @"qh_consigningTime" : @"goodsTime",
             
             @"qh_contractPrepaymentSum" : @"freightPrepaidSum",
             @"qh_contractFinalPaymentSum" : @"freifhtTailedSum",
             @"qh_contractOtherExpenseSum" : @"otherExpensesSum",
             @"qh_amount" : @"amount",
             
             };
}

/// 子模型类映射
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
//             @"qh_contractPrepayment" : GQHContractPaymentModel.class,
//             @"qh_contractFinalPayment" : GQHContractPaymentModel.class,
//             @"qh_contractOtherExpense" : GQHContractPaymentModel.class
             };
}

///  获取订单列表
+ (void)qh_fetchOrdersWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray<GQHOrderModel *> *orders))success failure:(void(^)(NSError *error))failure {
    
}

///  获取订单详情
+ (void)qh_fetchOrderDetailWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHOrderModel *order))success failure:(void(^)(NSError *error))failure {
    
}

@end
