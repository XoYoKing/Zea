//
//  GQHLevelModel.m
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHLevelModel.h"
#import "GQHHeader.h"


/// 本地归档文件名
static NSString * const kFileName = @"game_level.f";

@implementation GQHLevelModel

/**
 初始化Mock数据
 
 @return Mock数据
 */
- (instancetype)init {
    
    if (self = [super init]) {
        
        // mock
    }
    return self;
}

/**
 模型字段映射
 
 @return 模型字段映射字典
 */
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{
             
             @"qh_id" : @[@"id",@"iD",@"Id"],
             };
}

/**
 模型类映射
 
 @return 模型类映射字典
 */
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{
             
//             @"qh_books" : GQHBookModel.class,
             };
}

/**
 获取本地文件保存路径
 
 @param file 文件名
 @return 本地文件保存路径
 */
+ (NSString *)filePathWith:(NSString * _Nonnull )file {
    
    // 文件夹路径
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    return [NSString stringWithFormat:@"%@/%@", filePath, file];
}

/**
 编码解档
 
 @param aDecoder 编码器
 @return 自定义对象
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.qh_id = [aDecoder decodeObjectForKey:@"qh_id"];
        self.qh_title = [aDecoder decodeObjectForKey:@"qh_title"];
        self.qh_order = [aDecoder decodeObjectForKey:@"qh_order"];
        self.qh_detail = [aDecoder decodeObjectForKey:@"qh_detail"];
    }
    
    return self;
}

/**
 编码归档
 
 @param aCoder 编码器
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.qh_id forKey:@"qh_id"];
    [aCoder encodeObject:self.qh_title forKey:@"qh_title"];
    [aCoder encodeObject:self.qh_order forKey:@"qh_order"];
    [aCoder encodeObject:self.qh_detail forKey:@"qh_detail"];
}

/**
 安全编码
 
 @return 是否支持
 */
+ (BOOL)supportsSecureCoding {
    
    return YES;
}

#pragma mark -
/**
 增-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_createLevelWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 查-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_readLevelWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 改-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_updateLevelWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 删-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_deleteLevelWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

/**
 列表-
 
 @param parameters 请求参数
 @param handler 请求结果回调处理
 */
+ (void)qh_fetchLevelsWithParameters:(id)parameters handler:(void(^)(BOOL status, NSNumber *code, NSString *message, id data))handler {
    
}

#pragma mark - Setter

#pragma mark - Getter

@end
