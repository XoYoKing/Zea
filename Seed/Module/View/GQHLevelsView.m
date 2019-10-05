//
//  GQHLevelsView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHLevelsView.h"
#import "GQHHeader.h"


#pragma mark -

@interface GQHLevelsView ()

@end

@implementation GQHLevelsView

#pragma mark - Lifecycle
/**
 初始化控制器自定义根视图
 
 @param frame 自定义根视图的frame
 @return 自定义根视图
 */
- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"");
    
    if (self = [super initWithFrame:frame]) {
        
        // 初始化自动布局
        [self autoLayoutWithConstraints];
        
    }
    
    return self;
}

/**
 布局子视图 -> frame计算
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"");
    
}

/**
 自动布局子视图 -> 约束(mas_make只有一次,自动约束,不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
    // 集合视图
    [self addSubview:self.qh_collectionView];
    [self.qh_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 根据视图数据更新视图
 
 @param data 视图数据
 */
- (void)updateRootViewWithData:(id)data {
    NSLog(@"");
    
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 根据视图数据更新视图
    [self updateRootViewWithData:qh_data];
}

#pragma mark - Getter

- (UICollectionView *)qh_collectionView {
    
    if (!_qh_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        // CGRectZero
        _qh_collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _qh_collectionView.backgroundColor = [UIColor whiteColor];
        _qh_collectionView.showsHorizontalScrollIndicator = NO;
        _qh_collectionView.showsVerticalScrollIndicator = NO;
        
        // 注册cell
        [_qh_collectionView registerClass:[GQHLevelsCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GQHLevelsCollectionViewCell class])];
        
        if (@available(iOS 11.0, *)) {
            
            _qh_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _qh_collectionView;
}

@end


#pragma mark -

@interface GQHLevelsCollectionViewCell ()

@end

@implementation GQHLevelsCollectionViewCell

#pragma mark - Lifecycle

/**
 根据视图数据创建集合视图的单元格视图
 
 @param collectionView 集合视图
 @param indexPath 单元格视图的索引值
 @param data 视图数据
 @return 集合视图自定义单元格视图
 */
+ (instancetype)qh_collectionView:(UICollectionView *)collectionView cellForIndexPath:(NSIndexPath *)indexPath data:(id)data {
    NSLog(@"");
    
    GQHLevelsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GQHLevelsCollectionViewCell class]) forIndexPath:indexPath];
    
    // 根据视图数据更新视图
    cell.qh_data = data;
    
    // 单元格视图的索引值
    cell.qh_indexPath = indexPath;
    
    return cell;
}

/**
 初始化集合视图自定义单元格视图
 
 @param frame 自定义单元格视图的frame
 @return 自定义单元格视图
 */
- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"");
    
    if (self = [super initWithFrame:frame]) {
        
        // 初始化自动布局
        [self autoLayoutWithConstraints];
        
        // 其他初始化
        self.contentView.backgroundColor = [UIColor qh_colorWithRandomRGB];
    }
    
    return self;
}

/**
 布局自定义子视图
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"");
    
}

/**
 自动布局子视图 -> 约束(mas_make只有一次,自动约束,不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
}

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 根据视图数据更新视图
 
 @param data 视图数据
 */
- (void)updateCellWithData:(id)data {
    NSLog(@"");
    
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新cell的数据
    [self updateCellWithData:qh_data];
}

#pragma mark - Getter

@end
