//
//  AppDelegate+GQHDatabaseInstaller.m
//  Seed
//
//  Created by Mac on 2019/12/10.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "AppDelegate+GQHDatabaseInstaller.h"
#import "GQHDatabaseManager.h"
#import "GQHConstantHelper.h"
#import "GQHImageModel.h"
#import "GQHLevelModel.h"
#import "GQHMenuModel.h"
#import "GQHRecordModel.h"


@implementation AppDelegate (GQHDatabaseInstaller)

/// 初始化数据库
- (void)qh_installDatabase {
    
    [self migrateDatabase];
}

/// 迁移数据库
- (void)migrateDatabase {
    
    // 数据库文件路径
    NSString *databasePath = [GQHDatabaseManager.qh_sharedDatabaseManager qh_filePathWithDatabaseName:GQHDatabaseFileName];
    // 数据库版本号
    NSString *databaseVersion = [NSUserDefaults.standardUserDefaults valueForKey:GQHDatabaseVersionKey];
    // 应用程序版本号
    NSString *appVersion = [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    if (databasePath == nil) {
        
        // 初次安装应用程序
        
        // 图库表
        [self createGalleryDatabaseTable];
        // 等级表
        [self createLevelDatabaseTable];
        // 菜单表
        [self createMenuDatabaseTable];
        // 记录表
        [self createRecordDatabaseTable];
    } else {
        
        if (![databaseVersion isEqualToString:appVersion]) {
            
            //MARK:不需要数据迁移, 清除后重新添加
            // 图库表
            [self createGalleryDatabaseTable];
            // 等级表
            [self createLevelDatabaseTable];
            // 菜单表
            [self createMenuDatabaseTable];
            // 记录表
            [self createRecordDatabaseTable];
            
            //MARK:需要数据迁移, 版本单独对应
            if ([databaseVersion isEqualToString:@"4.0.1"]) {
                
                //TODO: 数据库版本号4.0.1 向当前版本迁移
                
            } else if ([databaseVersion isEqualToString:@"4.0.2"]) {
                
                //TODO: 数据库版本号4.0.2 向当前版本迁移
                
            }
        }
    }
    
    // 保存数据库版本号
    [NSUserDefaults.standardUserDefaults setValue:appVersion forKey:GQHDatabaseVersionKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

/// 创建图库表
- (void)createGalleryDatabaseTable {
    
    GQHDatabase database;
    // 数据库文件名
    database.db_name = GQHDatabaseFileName;
    // 数据库默认Documnets文件夹内
    database.db_path = nil;
    // 图库表名
    database.db_table = GQHDatabaseGalleryTable;
    // 图库表对应数据模型
    database.db_cls = [GQHImageModel class];
    
    // 清空数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_truncateDatabase:database]) {
        
        NSLog(@"清空数据表失败");
    }
    
    // 删除数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_dropDatabase:database]) {
        
        NSLog(@"删除数据表失败");
    }
    
    // 创建数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_createDatabase:database]) {
        
        NSLog(@"创建数据表失败");
    }
    
    // 插入数据
    GQHImageModel *model = [[GQHImageModel alloc] init];
    
    model.qh_title = @"animal";
    model.qh_image = @"db_gallery_animal_0";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"animal";
    model.qh_image = @"db_gallery_animal_1";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"animal";
    model.qh_image = @"db_gallery_animal_2";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"cultural";
    model.qh_image = @"db_gallery_cultural_0";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"natural";
    model.qh_image = @"db_gallery_natural_0";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"natural";
    model.qh_image = @"db_gallery_natural_1";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
}

/// 创建等级表
- (void)createLevelDatabaseTable {
    
    GQHDatabase database;
    // 数据库文件名
    database.db_name = GQHDatabaseFileName;
    // 数据库默认Documnets文件夹内
    database.db_path = nil;
    // 图库表名
    database.db_table = GQHDatabaseLevelTable;
    // 图库表对应数据模型
    database.db_cls = [GQHLevelModel class];
    
    // 清空数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_truncateDatabase:database]) {
        
        NSLog(@"清空数据表失败");
    }
    
    // 删除数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_dropDatabase:database]) {
        
        NSLog(@"删除数据表失败");
    }
    
    // 创建数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_createDatabase:database]) {
        
        NSLog(@"创建数据表失败");
    }
    
    // 插入数据
    GQHLevelModel *model = [[GQHLevelModel alloc] init];
    
    model.qh_title = @"god";
    model.qh_order = @"8";
    model.qh_detail = @"level_god_detail";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"guru";
    model.qh_order = @"7";
    model.qh_detail = @"level_guru_detail";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"master";
    model.qh_order = @"6";
    model.qh_detail = @"level_master_detail";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"senior";
    model.qh_order = @"5";
    model.qh_detail = @"level_senior_detail";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"junior";
    model.qh_order = @"4";
    model.qh_detail = @"level_junior_detail";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"newbie";
    model.qh_order = @"3";
    model.qh_detail = @"level_newbie_detail";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
}

/// 创建菜单表
- (void)createMenuDatabaseTable {
    
    GQHDatabase database;
    // 数据库文件名
    database.db_name = GQHDatabaseFileName;
    // 数据库默认Documnets文件夹内
    database.db_path = nil;
    // 图库表名
    database.db_table = GQHDatabaseMenuTable;
    // 图库表对应数据模型
    database.db_cls = [GQHMenuModel class];
    
    // 清空数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_truncateDatabase:database]) {
        
        NSLog(@"清空数据表失败");
    }
    
    // 删除数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_dropDatabase:database]) {
        
        NSLog(@"删除数据表失败");
    }
    
    // 创建数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_createDatabase:database]) {
        
        NSLog(@"创建数据表失败");
    }
    
    // 插入数据
    GQHMenuModel *model = [[GQHMenuModel alloc] init];
    
    model.qh_title = @"about";
    model.qh_icon = @"menu_about";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"help";
    model.qh_icon = @"menu_help";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"level";
    model.qh_icon = @"menu_level";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"gallery";
    model.qh_icon = @"menu_gallery";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"record";
    model.qh_icon = @"menu_record";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
    
    model.qh_title = @"start";
    model.qh_icon = @"menu_start";
    [GQHDatabaseManager.qh_sharedDatabaseManager qh_insertData:model intoDatabase:database];
}

/// 创建记录
- (void)createRecordDatabaseTable {
    
    GQHDatabase database;
    // 数据库文件名
    database.db_name = GQHDatabaseFileName;
    // 数据库默认Documnets文件夹内
    database.db_path = nil;
    // 图库表名
    database.db_table = GQHDatabaseRecordTable;
    // 图库表对应数据模型
    database.db_cls = [GQHRecordModel class];
    
    // 创建数据表
    if (![GQHDatabaseManager.qh_sharedDatabaseManager qh_createDatabase:database]) {
        
        NSLog(@"创建数据表失败");
    }
}

@end
