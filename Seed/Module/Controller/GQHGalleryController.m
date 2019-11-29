//
//  GQHGalleryController.m
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#pragma mark Other
#import "GQHHeader.h"

#pragma mark Model
#import "GQHImageModel.h"

#pragma mark View
#import "GQHGalleryView.h"

#pragma mark Controller
#import "GQHGalleryController.h"


#pragma mark -

@interface GQHGalleryController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, GQHGalleryViewDelegate>

/**
 自定义根视图
 */
@property (nonatomic, strong) GQHGalleryView *rootView;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray<GQHImageModel *> *dataSourceArray;

@end

@implementation GQHGalleryController

#pragma mark - Lifecycle
/**
 1.加载系统根视图或自定义根视图
 */
- (void)loadView {
    [super loadView];
    NSLog(@"");
    
    self.view = self.rootView;
}

/**
 2.视图加载完成
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"gallery", @"图库") forState:UIControlStateNormal];
}

/**
 3.视图即将显示
 
 @param animated 是否显示动画效果
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"");
    
}

/**
 4.视图即将布局其子视图
 */
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"");
    
}

/**
 5.视图已经布局其子视图
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"");
    
}

/**
 6.视图已经显示
 
 @param animated 是否显示动画效果
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"");
    
}

/**
 7.视图即将消失
 
 @param animated 是否显示动画效果
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"");
    
}

/**
 8.视图已经消失
 
 @param animated 是否显示动画效果
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"");
    
}

/**
 9.视图被销毁
 */
- (void)dealloc {
    NSLog(@"");
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = 0.5f * (self.rootView.qh_contentAreaWidth - 2 * GQHSpacing);
    CGFloat height = width + 35.0f;
    
    return CGSizeMake(width,height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeMake(self.rootView.qh_contentAreaWidth, 5.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(self.rootView.qh_contentAreaWidth, self.rootView.qh_homeIndicatorHeight + 5.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GQHGalleryViewImagesCollecionViewCell *cell = [GQHGalleryViewImagesCollecionViewCell qh_collectionView:collectionView cellForIndexPath:indexPath data:self.dataSourceArray[indexPath.row]];
    cell.qh_delegate = self;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    // 取消选中
    [self.dataSourceArray enumerateObjectsUsingBlock:^(GQHImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.qh_mark = NO;
    }];
    
    // 选中的标识保存本地
    GQHImageModel *image = self.dataSourceArray[indexPath.row];
    image.qh_mark = YES;
    [[NSUserDefaults standardUserDefaults] setObject:image.qh_image forKey:GQHGameImageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [collectionView reloadData];
}

#pragma mark - GQHGalleryViewDelegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

- (NSArray *)images {
    
    // 资源文件名
    NSString *fileName = @"db_puzzle.sqlite";
    // 数据表名
    NSString *tableName = @"p_gallery";
    
    // 等级列表
    __block NSMutableArray *images = [NSMutableArray array];
    
    NSString *path = [[NSBundle qh_bundle] pathForResource:fileName ofType:nil];
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc] initWithPath:path];
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open]) {
            
            if ([db tableExists:tableName]) {
                
                NSString *sql_query = [NSString stringWithFormat:@"SELECT * FROM '%@'",tableName];
                FMResultSet *resultSet = [db executeQuery:sql_query];
                
                while ([resultSet next]) {
                    
                    GQHImageModel *image = [[GQHImageModel alloc] init];
                    
                    [[resultSet resultDictionary] enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        
                        if ([key isEqualToString:@"p_gallery_id"]) {
                            
                            image.qh_id = obj;
                        } else if ([key isEqualToString:@"p_gallery_title"]) {
                            
                            image.qh_title = obj;
                        } else if ([key isEqualToString:@"p_gallery_image"]) {
                            
                            image.qh_image = obj;
                        }
                        
                        // 选中标识
                        NSString *mark = [NSUserDefaults.standardUserDefaults objectForKey:GQHGameImageKey];
                        if ([image.qh_image isEqualToString:mark]) {
                            
                            image.qh_mark = YES;
                        }
                    }];
                    
                    if (image.qh_id) {
                        
                        [images insertObject:image atIndex:[image.qh_id integerValue]];
                    }
                }
            }
        }
        
        [db close];
    }];
    
    return [images copy];
}

#pragma mark - Setter

#pragma mark - Getter
- (GQHGalleryView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHGalleryView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.backgroundColor = [UIColor qh_colorWithHexString:GQHColorWhiteSmoke];
        _rootView.qh_collectionView.delegate = self;
        _rootView.qh_collectionView.dataSource = self;
        _rootView.qh_delegate = self;
    }
    
    return _rootView;
}

- (NSMutableArray *)dataSourceArray {
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray arrayWithArray:[self images]];
        
        // 动物 animal
        // 自然风景 natural
        // 人工建筑 cultural
    }
    
    return _dataSourceArray;
}

@end
