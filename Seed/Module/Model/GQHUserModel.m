//
//  GQHUserModel.m
//  Xanthium
//
//  Created by GuanQinghao on 23/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHUserModel.h"
#import "GQHHeader.h"


NSString * const userIDKey = @"userIDKey";
NSString * const userMobileKey = @"userMobileKey";
NSString * const userAvatarKey = @"userAvatarKey";
NSString * const userNameKey = @"userNameKey";
NSString * const userTypeKey = @"userTypeKey";
NSString * const userScoreKey = @"userScoreKey";
NSString * const userAccessPermissionTypeKey = @"userAccessPermissionTypeKey";


@implementation GQHUserModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    
    
    return @{
             @"qh_userID" : @"userId",
             @"qh_userTypeCode" : @"userType",
             @"qh_mobile" : @[@"phone",@"phoneNum"],
             @"qh_userNickname" : @[@"nickName",@"name"],
             @"qh_avatar" : @"headImg",
             @"qh_mobileCode" : @"phoneCode",
             @"qh_orgName" : @"company",
             @"qh_supplyCount" : @"sourceNum",
             @"qh_followed" : @"friend",
             @"qh_departureID" : @"startPlace",
             @"qh_departure" : @"startPlace",
             @"qh_destinationID" : @"endPlace",
             @"qh_destination" : @"endPlace",
             @"qh_userTypeName" : @"type",
             @"qh_score" : @[@"avgScore",@"score"]
             };
    
    /**
     关注的货主
     "userId": "4028b881627ab35a01627b19a03a0002",
     "name": "货主",
     "headPortrait": "afbb0c4c913642e99505bf2762c817c1.jpg",
     "avgScore": 4.5,
     "type": "货主",
     "sourceNum": 4,
     "company": "---",
     "startPlace": "130127",
     "endPlace": "130431",
     "friend": true
     
     @property (nonatomic, copy) NSString *qh_userID;// 用户ID
     @property (nonatomic, copy) NSString *qh_userTypeCode;// 用户类型代码  04物流企业 03司机 02货主 01无车承运人 0为没有角色
     @property (nonatomic, copy) NSString *qh_userTypeName;// 用户类型名称
     @property (nonatomic, copy) NSString *qh_mobile;// 登录手机
     @property (nonatomic, copy) NSString *qh_userNickname;// 用户昵称
     @property (nonatomic, assign) CGFloat qh_score;// 用户评分
     @property (nonatomic, copy) NSString *qh_avatar;// 用户头像
     @property (nonatomic, copy) NSString *qh_mobileCode;// 验证码
     
     @property (nonatomic, copy) NSString *qh_orgName;// 用户所属机构名称
     @property (nonatomic, assign) NSInteger qh_supplyCount;// 用户货源数
     @property (nonatomic, assign) BOOL qh_followed;// 是否关注 (关注货主)
     @property (nonatomic, copy) NSString *qh_departureID;// 起始地行政编码
     @property (nonatomic, copy) NSString *qh_departure;// 起始地
     @property (nonatomic, copy) NSString *qh_destinationID;// 目的地行政编码
     @property (nonatomic, copy) NSString *qh_destination;// 目的地

     
     */
    
}

#pragma mark --登录
/// 登录请求
+ (void)qh_loginWithMobile:(NSString *)mobile password:(NSString *)password success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHUserModel *user))success failure:(void(^)(NSError *error))failure {
    
}

#pragma mark --注册
/// 请求验证码
+ (void)qh_requestCodeWithMobile:(NSString *)mobile success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHUserModel *user))success failure:(void(^)(NSError *error))failure {
    
}

/// 设置密码
+ (void)qh_setPasswordWith:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHUserModel *user))success failure:(void(^)(NSError *error))failure {
    
}

/// 修改密码
+ (void)qh_changePasswordWith:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message))success failure:(void(^)(NSError *error))failure {
    
}

/// 绑定手机号
+ (void)qh_bindMobileWith:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message))success failure:(void(^)(NSError *error))failure {
    
}

/// 获取关注的货主列表
+ (void)qh_fetchFollowedOwnersWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray<GQHUserModel *> *users))success failure:(void(^)(NSError *error))failure {
    
}

@end
