//
//  GQHImageModel.m
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHImageModel.h"
#import "GQHDatabaseManager.h"
#import "GQHConstantHelper.h"


@implementation GQHImageModel

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

/// 查询图片
+ (NSArray<GQHImageModel *> *)qh_fetchImageWithPage:(NSInteger)page {
    
    // 数据库
    GQHDatabase database;
    database.db_name = GQHDatabaseFileName;
    database.db_table = GQHDatabaseGalleryTable;
    database.db_cls = [GQHImageModel class];
    
    // 查询条件
    GQHSQLiteCondition condition;
    condition.db_database = database;
    condition.db_page = page;
    condition.db_size = 10;
    
    return [GQHDatabaseManager.qh_sharedDatabaseManager qh_queryDataWith:condition];
}

@end
