//
//  GQHBaseViewController.h
//  Seed
//
//  Created by GuanQinghao on 24/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 增查改删-页面类型
 
 - GQHCRUDTypeCreat: 增
 - GQHCRUDTypeRead: 查
 - GQHCRUDTypeUpdate: 改
 - GQHCRUDTypeDelete: 删
 */
typedef NS_ENUM(NSUInteger, GQHCRUDType) {
    
    GQHCRUDTypeCreat,
    GQHCRUDTypeRead,
    GQHCRUDTypeUpdate,
    GQHCRUDTypeDelete,
};


/**
 任意类型参数回调
 
 @param result 任意值
 */
typedef void (^GQHCustomBlock)(id _Nullable result);

/**
 布尔类型参数值回调
 
 @param flag 布尔值
 */
typedef void (^GQHCustomBooleanBlock)(BOOL flag);

/**
 字符串类型参数值回调
 
 @param string 字符串
 */
typedef void (^GQHCustomStringBlock)(NSString * _Nullable string);

/**
 数组类型参数值回调
 
 @param array 数组
 */
typedef void (^GQHCustomArrayBlock)(NSArray * _Nullable array);

/**
 字典类型参数值回调
 
 @param dictionary 字典
 */
typedef void (^GQHCustomDictionarybBlock)(NSDictionary * _Nullable dictionary);


NS_ASSUME_NONNULL_BEGIN

/**
 应用程序控制器基类
 */
@interface GQHBaseViewController : UIViewController

/**
 页面类型
 */
@property (nonatomic, assign) GQHCRUDType qh_crudType;

@end

NS_ASSUME_NONNULL_END
