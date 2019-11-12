//
//  GQHHomeView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHHomeView.h"
#import "GQHHeader.h"


#pragma mark -

@interface GQHHomeView ()

//TODO:彩蛋
/**
 背景视图-(普通:渐变色 彩蛋:背景图片)
 */
@property (nonatomic, strong) UIImageView *gradientImageView;

@end

@implementation GQHHomeView

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
        
        // 其他初始化
        
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
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight);
        make.bottom.mas_equalTo(self).with.inset(self.qh_homeIndicatorHeight);
        make.left.and.right.mas_equalTo(self).with.inset(15.0f);
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
        _qh_collectionView.showsHorizontalScrollIndicator = NO;
        _qh_collectionView.showsVerticalScrollIndicator = NO;
        _qh_collectionView.pagingEnabled = NO;
        _qh_collectionView.bounces = YES;
        _qh_collectionView.alwaysBounceVertical = YES;
        _qh_collectionView.backgroundColor = UIColor.clearColor;
        
        // 注册cell
        [_qh_collectionView registerClass:[GQHHomeViewMenusCollecionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GQHHomeViewMenusCollecionViewCell class])];
        
        // 注册headerView
        [_qh_collectionView registerClass:[GQHHomeViewWelcomCollectionViewReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([GQHHomeViewWelcomCollectionViewReusableHeaderView class])];

        if (@available(iOS 11.0, *)) {
            
            _qh_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _qh_collectionView;
}

@end


#pragma mark -

@interface GQHHomeViewMenusCollecionViewCell ()

/**
 容器视图
 */
@property (nonatomic, strong) UIView *containerView;

/**
 图片
 */
@property (nonatomic, strong) UIImageView *menuImageView;

/**
 标题
 */
@property (nonatomic, strong) UILabel *menuTitleLabel;

/**
 索引
 */
@property (nonatomic, assign) NSIndexPath *index;

@end

@implementation GQHHomeViewMenusCollecionViewCell

#pragma mark - Lifecycle
+ (instancetype)qh_collectionView:(UICollectionView *)collectionView cellForIndexPath:(NSIndexPath *)indexPath data:(nullable id)data {
    NSLog(@"");
    
    GQHHomeViewMenusCollecionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GQHHomeViewMenusCollecionViewCell class]) forIndexPath:indexPath];
    
    // 根据视图数据更新视图
    [cell updateCellWithData:data];
    
    cell.index = indexPath;
    
    return cell;
}

/**
 初始化自定义单元格视图
 
 @param frame 单元格视图frame
 @return 自定义单元格视图
 */
- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"");
    
    if (self = [super initWithFrame:frame]) {
        
        // 初始化自动布局
        [self autoLayoutWithConstraints];
        
        // 其他初始化
        
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
 自动布局子视图 -> 约束(mas_make只有一次,自动约束，不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
    // 容器视图
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f));
    }];
    
    // 菜单标题
    [self.containerView addSubview:self.menuTitleLabel];
    [self.menuTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.bottom.and.right.mas_equalTo(self.containerView).with.inset(10.0f);
        make.height.mas_greaterThanOrEqualTo(GQHMinLayoutValue);
    }];
    
    // 菜单图片
    [self.containerView addSubview:self.menuImageView];
    [self.menuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.containerView);
        make.top.mas_equalTo(self.containerView).with.inset(GQHMinLayoutValue);
        make.bottom.mas_equalTo(self.menuTitleLabel.mas_top).with.inset(GQHMinLayoutValue);
        make.width.mas_equalTo(self.menuImageView.mas_height).with.multipliedBy(1.0f);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 根据视图数据更新视图
 
 @param data 单元格视图数据
 */
- (void)updateCellWithData:(id)data {
    NSLog(@"");
    
    if (data) {
        
        self.menuImageView.image = [UIImage imageNamed:[data objectForKey:@"image"]];
        self.menuTitleLabel.text = NSLocalizedString([data objectForKey:@"title"], @"title");
    }
    
    self.menuImageView.backgroundColor = [UIColor qh_randomColor];
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新cell的数据
    [self updateCellWithData:qh_data];
}

#pragma mark - Getter

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        
        _containerView.layer.shadowColor = UIColor.lightGrayColor.CGColor;
        _containerView.layer.shadowOpacity = 0.6f;
        _containerView.layer.shadowRadius = 4.0f;
        _containerView.layer.shadowOffset = CGSizeMake(4.0f, 4.0f);
    }
    
    return _containerView;
}

- (UIImageView *)menuImageView {
    
    if (!_menuImageView) {
        
        _menuImageView = [[UIImageView alloc] init];
        _menuImageView.backgroundColor = [UIColor clearColor];
        
        _menuImageView.image = [UIImage imageNamed:@""];
        
        _menuImageView.layer.cornerRadius = 0.0f;
        _menuImageView.layer.masksToBounds = YES;
    }
    
    return _menuImageView;
}

- (UILabel *)menuTitleLabel {
    
    if (!_menuTitleLabel) {
        
        _menuTitleLabel = [[UILabel alloc] init];
        _menuTitleLabel.backgroundColor = [UIColor clearColor];
        
        _menuTitleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
        _menuTitleLabel.textColor = [UIColor darkTextColor];
        _menuTitleLabel.textAlignment = NSTextAlignmentCenter;
        _menuTitleLabel.numberOfLines = 1;
    }
    
    return _menuTitleLabel;
}

@end


#pragma mark -

@interface GQHHomeViewWelcomCollectionViewReusableHeaderView ()

/**
 容器视图
 */
@property (nonatomic, strong) UIView *containerView;

/**
 欢迎标题
 */
@property (nonatomic, strong) UILabel *welcomTitleLabel;

/**
 索引
 */
@property (nonatomic, assign) NSIndexPath *index;

@end

@implementation GQHHomeViewWelcomCollectionViewReusableHeaderView

#pragma mark - Lifecycle
+ (instancetype)qh_collectionView:(UICollectionView *)collectionView headerViewForIndexPath:(NSIndexPath *)indexPath data:(id)data {
    NSLog(@"");
    
    GQHHomeViewWelcomCollectionViewReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: NSStringFromClass([GQHHomeViewWelcomCollectionViewReusableHeaderView class]) forIndexPath:indexPath];
    
    // 根据视图数据更新视图
    [headerView updateHeaderViewWithData:data];
    
    headerView.index = indexPath;
    
    return headerView;
}

/**
 初始化集合视图自定义头视图
 
 @param frame 集合视图头视图frame
 @return 自定义集合头视图
 */
- (instancetype)initWithFrame:(CGRect)frame {
    NSLog(@"");
    
    if (self = [super initWithFrame:frame]) {
        
        // 初始化自动布局
        [self autoLayoutWithConstraints];
        
        // 其他初始化
        
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
 自动布局子视图 -> 约束(mas_make只有一次,自动约束，不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
    // 容器视图
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
    
    // 欢迎标题
    [self.containerView addSubview:self.welcomTitleLabel];
    [self.welcomTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 根据视图数据更新视图
 
 @param data 集合头视图数据
 */
- (void)updateHeaderViewWithData:(id)data {
    NSLog(@"");
    
    self.welcomTitleLabel.backgroundColor = [UIColor qh_randomColor];
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新头视图数据
    [self updateHeaderViewWithData:qh_data];
}

#pragma mark - Getter

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        
        _containerView.layer.cornerRadius = 0.0f;
        _containerView.layer.masksToBounds = YES;
    }
    
    return _containerView;
}

- (UILabel *)welcomTitleLabel {
    
    if (!_welcomTitleLabel) {
        
        _welcomTitleLabel = [[UILabel alloc] init];
        _welcomTitleLabel.backgroundColor = [UIColor whiteColor];
        
        _welcomTitleLabel.font = [UIFont systemFontOfSize:32.0f];
        _welcomTitleLabel.text = NSLocalizedString(@"Welcome\nPuzzle", @"Label");
        _welcomTitleLabel.textColor = [UIColor darkTextColor];
        _welcomTitleLabel.textAlignment = NSTextAlignmentCenter;
        _welcomTitleLabel.numberOfLines = 0;
    }
    
    return _welcomTitleLabel;
}

@end
