//
//  GQHHomeView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHBaseView.h"


/**
 自定义视图的代理
 */
@protocol GQHHomeViewDelegate <NSObject>

@required

@optional

@end


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 自定义根视图
 */
@interface GQHHomeView : GQHBaseView

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHHomeViewDelegate> qh_delegate;

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 集合视图
 */
@property (nonatomic, strong) UICollectionView *qh_collectionView;

@end

NS_ASSUME_NONNULL_END


#pragma mark -

NS_ASSUME_NONNULL_BEGIN

/**
 首页菜单按钮视图
 */
@interface GQHHomeViewMenusCollecionViewCell : UICollectionViewCell

/**
 视图代理
 */
@property (nonatomic, weak) id<GQHHomeViewDelegate> qh_delegate;

/**
 视图数据
 */
@property (nonatomic, strong) id qh_data;

/**
 根据视图数据创建集合视图的单元格视图
 
 @param collectionView 集合视图
 @param indexPath 单元格视图的索引值
 @param data 单元格视图数据
 @return 自定义单元格视图
 */
+ (instancetype)qh_collectionView:(UICollectionView *)collectionView cellForIndexPath:(NSIndexPath *)indexPath data:(nullable id)data;

@end

NS_ASSUME_NONNULL_END
