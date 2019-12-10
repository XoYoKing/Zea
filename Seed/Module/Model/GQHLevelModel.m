//
//  GQHLevelModel.m
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHLevelModel.h"
#import "GQHDatabaseManager.h"
#import "GQHConstantHelper.h"


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

/// 查询等级
+ (NSArray<GQHLevelModel *> *)qh_allLevels {
    
    // 数据库
    GQHDatabase database;
    database.db_name = GQHDatabaseFileName;
    database.db_table = GQHDatabaseLevelTable;
    database.db_cls = [GQHLevelModel class];
    
    // 查询条件
    GQHSQLiteCondition condition;
    condition.db_database = database;
    
    return [GQHDatabaseManager.qh_sharedDatabaseManager qh_queryDataWith:condition];
}

@end
