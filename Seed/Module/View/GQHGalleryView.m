//
//  GQHGalleryView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHGalleryView.h"
#import "GQHHeader.h"
#import "GQHImageModel.h"


#pragma mark -

@interface GQHGalleryView ()

@end

@implementation GQHGalleryView

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
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight + self.qh_navigationBarHeight);
        make.left.and.right.mas_equalTo(self).with.inset(GQHSpacing);
        make.bottom.mas_equalTo(self);
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
        _qh_collectionView.backgroundColor = [UIColor clearColor];
        
        // 注册cell
        [_qh_collectionView registerClass:[GQHGalleryViewImagesCollecionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GQHGalleryViewImagesCollecionViewCell class])];
        
        if (@available(iOS 11.0, *)) {
            
            _qh_collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _qh_collectionView;
}

@end


#pragma mark -

@interface GQHGalleryViewImagesCollecionViewCell ()

/**
 游戏图片
 */
@property (nonatomic, strong) UIImageView *gameImageView;

/**
 图片标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 索引
 */
@property (nonatomic, assign) NSIndexPath *index;

@end

@implementation GQHGalleryViewImagesCollecionViewCell

#pragma mark - Lifecycle
+ (instancetype)qh_collectionView:(UICollectionView *)collectionView cellForIndexPath:(NSIndexPath *)indexPath data:(nullable id)data {
    NSLog(@"");
    
    GQHGalleryViewImagesCollecionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GQHGalleryViewImagesCollecionViewCell class]) forIndexPath:indexPath];
    
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
    
    // 游戏图片
    [self.contentView addSubview:self.gameImageView];
    [self.gameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView).with.inset(GQHSpacing);
        make.left.and.right.mas_equalTo(self.contentView).with.inset(0.5f * GQHSpacing);
        make.width.mas_equalTo(self.gameImageView.mas_height).with.multipliedBy(1.0f);
    }];
    
    // 图片标题
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.gameImageView.mas_bottom);
        make.bottom.mas_equalTo(self.contentView);
        make.left.and.right.mas_equalTo(self.gameImageView);
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
        
        GQHImageModel *image = (GQHImageModel *)data;
        
        self.gameImageView.image = [UIImage imageNamed:image.qh_image];
        self.titleLabel.text = NSLocalizedString(image.qh_title, @"title");
        
        // 选中标识
        if (image.qh_mark) {
            
            self.gameImageView.layer.borderColor = [UIColor qh_colorWithHexString:@"#DB3C1f"].CGColor;
            self.gameImageView.layer.borderWidth = 5.0f;
        } else {
            
            self.gameImageView.layer.borderColor = UIColor.clearColor.CGColor;
            self.gameImageView.layer.borderWidth = 0.0f;
        }
    }
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新cell的数据
    [self updateCellWithData:qh_data];
}

#pragma mark - Getter

- (UIImageView *)gameImageView {
    
    if (!_gameImageView) {
        
        _gameImageView = [[UIImageView alloc] init];
        _gameImageView.backgroundColor = [UIColor clearColor];
        _gameImageView.userInteractionEnabled = YES;
        
        _gameImageView.image = [UIImage imageNamed:@""];
        
        _gameImageView.layer.cornerRadius = 2.0f;
        _gameImageView.layer.masksToBounds = YES;
    }
    
    return _gameImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _titleLabel.font = [UIFont fontWithName:GQHFontNamePFSMedium size:16.0f];
        _titleLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkGray];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
    }
    
    return _titleLabel;
}

@end
