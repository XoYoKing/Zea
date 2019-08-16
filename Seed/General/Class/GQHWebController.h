//
//  GQHWebController.h
//
//  Created by GuanQinghao on 2019-05-09.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseViewController.h"


NS_ASSUME_NONNULL_BEGIN

/**
 富文本和网页控制器
 */
@interface GQHWebController : GQHBaseViewController

/**
 URL地址或富文本内容
 */
@property (nonatomic, copy) NSString *qh_contentString;

/**
 URL地址
 */
@property (nonatomic, copy) NSString *qh_URLString;

/**
 富文本内容
 */
@property (nonatomic, copy) NSString *qh_HTMLString;

@end

NS_ASSUME_NONNULL_END
