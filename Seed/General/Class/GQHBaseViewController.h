//
//  GQHBaseViewController.h
//  Seed
//
//  Created by GuanQinghao on 24/09/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 增查改删

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


NS_ASSUME_NONNULL_BEGIN

/**
 应用程序控制器基类
 */
@interface GQHBaseViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
