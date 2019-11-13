//
//  GQHGalleryController.m
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#pragma mark Other
#import "GQHHeader.h"

#pragma mark Model

#pragma mark View
#import "GQHGalleryView.h"

#pragma mark Controller
#import "GQHGalleryController.h"


#pragma mark -

@interface GQHGalleryController () <UICollectionViewDelegate, UICollectionViewDataSource, GQHGalleryViewDelegate>

/**
 自定义根视图
 */
@property (nonatomic, strong) GQHGalleryView *rootView;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSourceArray;

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
    
    [self.qh_titleButton setTitle:@"选择游戏图片" forState:UIControlStateNormal];
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
    
    CGFloat width = 0.5f * (self.rootView.qh_contentAreaWidth - 30.0f);
    CGFloat height = width + 35.0f;
    
    return CGSizeMake(width,height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return CGSizeZero;
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
    
}

#pragma mark - GQHGalleryViewDelegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

#pragma mark - Setter

#pragma mark - Getter
- (GQHGalleryView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHGalleryView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.backgroundColor = [UIColor whiteColor];
        _rootView.qh_collectionView.delegate = self;
        _rootView.qh_collectionView.dataSource = self;
        _rootView.qh_delegate = self;
    }
    
    return _rootView;
}

- (NSMutableArray *)dataSourceArray {
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray array];
        
        _dataSourceArray = @[@{@"image":@"",@"title":@"start"}.mutableCopy,
        @{@"image":@"",@"title":@"record"}.mutableCopy,
        @{@"image":@"",@"title":@"gallery"}.mutableCopy,
        @{@"image":@"",@"title":@"level"}.mutableCopy,
        @{@"image":@"",@"title":@"help"}.mutableCopy,
        @{@"image":@"",@"title":@"about"}.mutableCopy].mutableCopy;
    }
    
    return _dataSourceArray;
}

@end
