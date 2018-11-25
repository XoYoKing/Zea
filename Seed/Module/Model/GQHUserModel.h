//
//  GQHUserModel.h
//  Xanthium
//
//  Created by GuanQinghao on 23/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHBaseModel.h"


extern NSString * const userIDKey;                          /// 用户 ID Key值
extern NSString * const userMobileKey;                      /// 用户手机号Key值
extern NSString * const userAvatarKey;                      /// 用户头像Key值
extern NSString * const userNameKey;                        /// 用户姓名Key值
extern NSString * const userTypeKey;                        /// 用户角色类型Key值
extern NSString * const userScoreKey;                       /// 用户评分Key值
extern NSString * const userAccessPermissionTypeKey;        /// 用户访问权限Key值


@interface GQHUserModel : GQHBaseModel 

// 基本信息
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

@property (nonatomic, copy) NSString *token;// token
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *auditState;// 认证状态  01已认证  02待认证  03未认证
@property (nonatomic, copy) NSString *applyTime;//认证申请时间
@property (nonatomic, copy) NSString *auditTime;//审核时间
@property (nonatomic, copy) NSString *auditor;//审核人
@property (nonatomic, copy) NSString *empName;//联系人
@property (nonatomic, copy) NSString *phoneNum;//联系电话
@property (nonatomic, copy) NSString *positiveIdCard;//身份证正面照
@property (nonatomic, copy) NSString *backIdCard;//身份证反面照
@property (nonatomic, copy) NSString *companyName;//企业名称
@property (nonatomic, copy) NSString *companyAdd;//公司地址
//用户类型  04物流企业
@property (nonatomic, copy) NSString *businessLicPhoto;//营业执照照片
@property (nonatomic, copy) NSString *roadTraBuLic;//道路运输经营许可证照片
@property (nonatomic, copy) NSString *busLicNum;//营业执照编号
@property (nonatomic, copy) NSString *busIdCard;//身份证号
//用户类型  03司机
@property (nonatomic, copy) NSString *userName;//用户名
@property (nonatomic, copy) NSString *headPortrait;//头像
@property (nonatomic, copy) NSString *qrivingLicPhoto;//驾驶证照片
@property (nonatomic, copy) NSString *qualCerPhoto;//从业资格证照片
@property (nonatomic, copy) NSString *qualCerNum;//从业资格证号码
@property (nonatomic, copy) NSString *dirIdCard;//身份证号
@property (nonatomic, copy) NSString *ownerType;//所有者类型  个人、企业 选择个人
@property (nonatomic, copy) NSString *ownerIdNum;//所有人身份证号/营业执照号
@property (nonatomic, copy) NSString *licPlateNum;//车牌号
@property (nonatomic, copy) NSString *carQrivingLicPhoto;//行驶证照片
@property (nonatomic, copy) NSString *ownerCerPhoto;//所有者证件照片  所有人身份
@property (nonatomic, copy) NSString *roadTraCerLic;//道路运输证  图片
@property (nonatomic, copy) NSString *roadTraBuLicNum;//道路经营许可编号
@property (nonatomic, copy) NSString *roadTraCerNum;//道路运输证号
@property (nonatomic, copy) NSString *trailerRegistrationNum;//挂车牌照号  选填
@property (nonatomic, copy) NSString *licenseplatetypecode;//车牌类型 列表选择，
@property (nonatomic, copy) NSString *vehicleclassificationcode;//车型     列
@property (nonatomic, copy) NSString *carLength;//车长  列表
@property (nonatomic, copy) NSString *carLoad;//载重
@property (nonatomic, copy) NSString *carPhoto;//车辆照片  两张照片
//用户类型  01无车承运人
@property (nonatomic, copy) NSString *idNumber;//身份证号
@property (nonatomic, copy) NSString *businessLicenseNumber;//营业执照照片
@property (nonatomic, copy) NSString *enterpriseAccessCode;//企业接入码照片
@property (nonatomic, copy) NSString *enterpriseAccessAppkey;//企业接入AppKey码
@property (nonatomic, copy) NSString *socialCreditCode;//社会信用代码
@property (nonatomic, copy) NSString *selfPortrait;//本人正面照
@property (nonatomic, copy) NSString *storePhotos;//门店照片照片
@property (nonatomic, copy) NSString *businessLicensePjoto;//营业执照照片
@property (nonatomic, copy) NSString *transportRoadPermit;//运输道路许可证码
@property (nonatomic, copy) NSString *enterpriseTaxCertificate;//企业纳税凭证
@property (nonatomic, copy) NSString *transportRoadPermitNum;//道路许可证号

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
 
 */


/// 手机号/密码登录
+ (void)qh_loginWithMobile:(NSString *)mobile password:(NSString *)password success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHUserModel *user))success failure:(void(^)(NSError *error))failure;

/// 请求验证码
+ (void)qh_requestCodeWithMobile:(NSString *)mobile success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHUserModel *user))success failure:(void(^)(NSError *error))failure;

/// 设置密码
+ (void)qh_setPasswordWith:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, GQHUserModel *user))success failure:(void(^)(NSError *error))failure;

/// 修改密码
+ (void)qh_changePasswordWith:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message))success failure:(void(^)(NSError *error))failure;

/// 绑定手机号
+ (void)qh_bindMobileWith:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message))success failure:(void(^)(NSError *error))failure;

/// 获取关注的货主列表
+ (void)qh_fetchFollowedOwnersWithParameters:(NSDictionary *)parameters success:(void(^)(BOOL status, NSNumber *code, NSString *message, NSArray<GQHUserModel *> *users))success failure:(void(^)(NSError *error))failure;

@end
