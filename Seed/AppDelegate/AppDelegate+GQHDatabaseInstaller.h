//
//  AppDelegate+GQHDatabaseInstaller.h
//  Seed
//
//  Created by Mac on 2019/12/10.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (GQHDatabaseInstaller)

/// 初始化数据库
- (void)qh_installDatabase;

@end

NS_ASSUME_NONNULL_END
