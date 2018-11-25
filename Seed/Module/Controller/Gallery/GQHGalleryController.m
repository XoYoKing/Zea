//
//  GQHGalleryController.m
//  Seed
//
//  Created by GuanQinghao on 08/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#pragma mark Macro
#import "GQHHeader.h"

#pragma mark Model

#pragma mark Object
#import "GQHImageCuttingHelper.h"

#pragma mark View
#import "GQHGalleryView.h"

#pragma mark Controller
#import "GQHGalleryController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------


@interface GQHGalleryController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/// 自定义根视图
@property (nonatomic, strong) GQHGalleryView *rootView;
/// 本地图集数组
@property (nonatomic, strong) NSArray *imageArray;
/// 选中的图片索引
@property (nonatomic, assign) NSInteger *selectedIndex;
@end


@implementation GQHGalleryController

#pragma mark --Lifecycle
- (void)loadView {
    // 添加自定义视图
    DLog();
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog();
    
    [self.qh_titleButton setTitle:NSLocalizedString(@"gallery", @"游戏图库") forState:UIControlStateNormal];
    [self.qh_rightMostButton setBackgroundImage:[UIImage imageNamed:@"gallery_add"] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog();
    
}

#pragma mark --Delegate
/// 集合子视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat imageWidth = 0.5f * self.view.qh_width - 15.0f;
    
    return CGSizeMake(imageWidth, imageWidth);
}
/// 集合视图段边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}
/// 集合子视图列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.0f;
}
/// 集合子视图行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.0f;
}
/// 集合视图段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
/// 集合子视图个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}
/// 集合子视图设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GQHGalleryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GQHGalleryViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[GQHGalleryViewCell alloc] init];
        cell.backgroundColor = UIColor.clearColor;
    }
    
    [cell setSelected:NO animated:YES];
    cell.qh_imageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    
    
    /// 进入菜单页面默认选中Cell
    NSString *imageName = self.imageArray[indexPath.row];
    NSString *selectedImageName = [NSUserDefaults.standardUserDefaults objectForKey:GQHUserImageKey];
    
    DLog(@"%@--%@",imageName,selectedImageName);
    
    if ([selectedImageName isEqualToString:imageName]) {
        
        [cell setSelected:YES animated:YES];
    }
    
    
    
    return cell;
}
/// 选择集合子视图
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *imageName = [NSString stringWithFormat:@"puzzle_%1ld",indexPath.row];
    [NSUserDefaults.standardUserDefaults setObject:imageName forKey:GQHUserImageKey];
    DLog(@"%@",imageName);
    [self.rootView.qh_imageCollectionView reloadData];
    
    
    // 切图
    UIImage *image = [UIImage imageNamed:imageName];
    NSNumber *levelNumber = [NSUserDefaults.standardUserDefaults valueForKey:GQHUserLevelKey];
    NSInteger levelValue = [levelNumber integerValue];
    [GQHImageCuttingHelper qh_cutImage:image byRow:levelValue column:levelValue quality:1.0f];
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark --TargetMethod

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (GQHGalleryView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHGalleryView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.backgroundColor = UIColor.whiteColor;
        _rootView.qh_imageCollectionView.delegate = self;
        _rootView.qh_imageCollectionView.dataSource = self;
    }
    
    return _rootView;
}

- (NSArray *)imageArray {
    
    if (!_imageArray) {
        
        _imageArray = @[@"puzzle_0",@"puzzle_1",@"puzzle_2",@"puzzle_3",@"puzzle_4",@"puzzle_5",@"puzzle_6",@"puzzle_7"];
    }
    
    return _imageArray;
}

@end
