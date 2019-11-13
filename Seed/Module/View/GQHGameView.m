//
//  GQHGameView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHGameView.h"
#import "GQHHeader.h"


#pragma mark -

@interface GQHGameView ()

//MARK: 记分板(scoreboard)

/**
 记分板背景视图
 */
@property (nonatomic, strong) UIView *scoreboardBackgroundView;

/**
 图片预览视图
 */
@property (nonatomic, strong) UIImageView *previewImageView;

/**
 最佳记录背景视图
 */
@property (nonatomic, strong) UIView *bestBackgroundView;

/**
 最佳时间标题
 */
@property (nonatomic, strong) UILabel *bestTimeTitleLabel;

/**
 最佳时间
 */
@property (nonatomic, strong) UILabel *bestTimeTextLabel;

/**
 最佳计数标题
 */
@property (nonatomic, strong) UILabel *bestCountTittleLabel;

/**
 最佳计数
 */
@property (nonatomic, strong) UILabel *bestCountTextLabel;

/**
 当前记录背景视图
 */
@property (nonatomic, strong) UIView *currentBackgroundView;

/**
 当前时间标题
 */
@property (nonatomic, strong) UILabel *currentTimeTitleLabel;

/**
 当前时间
 */
@property (nonatomic, strong) UILabel *currentTimeTextLabel;

/**
 当前计数标题
 */
@property (nonatomic, strong) UILabel *currentCountTittleLabel;

/**
 当前计数
 */
@property (nonatomic, strong) UILabel *currentCountTextLabel;

//MARK: 游戏板(gameboard)
/**
 游戏板背景视图
 */
@property (nonatomic, strong) UIView *gameboardBackgroundView;

/**
 游戏板视图
 */
@property (nonatomic, strong) UIView *gameboardView;

@end

@implementation GQHGameView

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
    
    //MARK: 记分板(scoreboard)
    // 记分板背景视图
    [self addSubview:self.scoreboardBackgroundView];
    [self.scoreboardBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight + self.qh_navigationBarHeight + 10.0f);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(170.0f);
    }];
    
    // 图片预览视图
    [self.scoreboardBackgroundView addSubview:self.previewImageView];
    [self.previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.bottom.mas_equalTo(self.scoreboardBackgroundView).with.inset(10.0f);
        make.width.mas_equalTo(self.previewImageView.mas_height).with.multipliedBy(1.0f);
    }];
    
    // 最佳记录背景视图
    [self.scoreboardBackgroundView addSubview:self.bestBackgroundView];
    [self.bestBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.right.mas_equalTo(self.scoreboardBackgroundView).with.inset(10.0f);
        make.left.mas_equalTo(self.previewImageView.mas_right).with.inset(10.0f);
        make.height.mas_equalTo(70.0f);
    }];
    
    // 最佳时间标题
    [self.bestBackgroundView addSubview:self.bestTimeTitleLabel];
    [self.bestTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bestBackgroundView).with.inset(5.0f);
        make.left.mas_equalTo(self.bestBackgroundView);
        make.width.mas_equalTo(self.bestBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 最佳时间
    [self.bestBackgroundView addSubview:self.bestTimeTextLabel];
    [self.bestTimeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bestBackgroundView).with.inset(5.0f);
        make.right.mas_equalTo(self.bestBackgroundView);
        make.width.mas_equalTo(self.bestBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 最佳计数标题
    [self.bestBackgroundView addSubview:self.bestCountTittleLabel];
    [self.bestCountTittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.bestBackgroundView).with.inset(5.0f);
        make.left.mas_equalTo(self.bestBackgroundView);
        make.width.mas_equalTo(self.bestBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 最佳计数
    [self.bestBackgroundView addSubview:self.bestCountTextLabel];
    [self.bestCountTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.bestBackgroundView).with.inset(5.0f);
        make.right.mas_equalTo(self.bestBackgroundView);
        make.width.mas_equalTo(self.bestBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 当前记录背景视图
    [self.scoreboardBackgroundView addSubview:self.currentBackgroundView];
    [self.currentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.and.right.mas_equalTo(self.scoreboardBackgroundView).with.inset(10.0f);
        make.left.mas_equalTo(self.previewImageView.mas_right).with.inset(10.0f);
        make.height.mas_equalTo(70.0f);
    }];
    
    // 当前时间标题
    [self.currentBackgroundView addSubview:self.currentTimeTitleLabel];
    [self.currentTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.currentBackgroundView).with.inset(5.0f);
        make.left.mas_equalTo(self.currentBackgroundView);
        make.width.mas_equalTo(self.currentBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 当前时间
    [self.currentBackgroundView addSubview:self.currentTimeTextLabel];
    [self.currentTimeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.currentBackgroundView).with.inset(5.0f);
        make.right.mas_equalTo(self.currentBackgroundView);
        make.width.mas_equalTo(self.currentBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 当前计数标题
    [self.currentBackgroundView addSubview:self.currentCountTittleLabel];
    [self.currentCountTittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.currentBackgroundView).with.inset(5.0f);
        make.left.mas_equalTo(self.currentBackgroundView);
        make.width.mas_equalTo(self.currentBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 当前计数
    [self.currentBackgroundView addSubview:self.currentCountTextLabel];
    [self.currentCountTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.currentBackgroundView).with.inset(5.0f);
        make.right.mas_equalTo(self.currentBackgroundView);
        make.width.mas_equalTo(self.currentBackgroundView.mas_width).with.multipliedBy(0.5f);
        make.height.mas_equalTo(30.0f);
    }];
    
    //MARK: 游戏板(gameboard)
    // 游戏板背景视图
    [self addSubview:self.gameboardBackgroundView];
    [self.gameboardBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.scoreboardBackgroundView.mas_bottom).with.inset(10.0f);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(self.gameboardBackgroundView.mas_width).with.multipliedBy(1.0f);
    }];
    
    // 游戏板视图
    [self.gameboardBackgroundView addSubview:self.gameboardView];
    [self.gameboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.gameboardBackgroundView).with.insets(UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f));
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

- (UIView *)scoreboardBackgroundView {
    
    if (!_scoreboardBackgroundView) {
        
        _scoreboardBackgroundView = [[UIView alloc] init];
        _scoreboardBackgroundView.backgroundColor = [UIColor whiteColor];
        
        _scoreboardBackgroundView.layer.cornerRadius = 0.0f;
        _scoreboardBackgroundView.layer.masksToBounds = YES;
    }
    
    return _scoreboardBackgroundView;
}

- (UIImageView *)previewImageView {
    
    if (!_previewImageView) {
        
        _previewImageView = [[UIImageView alloc] init];
        _previewImageView.backgroundColor = [UIColor qh_randomColor];
        
        _previewImageView.image = [UIImage imageNamed:@""];
        
        _previewImageView.layer.cornerRadius = 0.0f;
        _previewImageView.layer.masksToBounds = YES;
    }
    
    return _previewImageView;
}

- (UIView *)bestBackgroundView {
    
    if (!_bestBackgroundView) {
        
        _bestBackgroundView = [[UIView alloc] init];
        _bestBackgroundView.backgroundColor = [UIColor qh_randomColor];
        
        _bestBackgroundView.layer.cornerRadius = 0.0f;
        _bestBackgroundView.layer.masksToBounds = YES;
    }
    
    return _bestBackgroundView;
}

- (UILabel *)bestTimeTitleLabel {
    
    if (!_bestTimeTitleLabel) {
        
        _bestTimeTitleLabel = [[UILabel alloc] init];
        _bestTimeTitleLabel.backgroundColor = [UIColor clearColor];
        
        _bestTimeTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _bestTimeTitleLabel.text = NSLocalizedString(@"Label", @"Label");
        _bestTimeTitleLabel.textColor = [UIColor darkTextColor];
        _bestTimeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _bestTimeTitleLabel.numberOfLines = 0;
    }
    
    return _bestTimeTitleLabel;
}

- (UILabel *)bestTimeTextLabel {
    
    if (!_bestTimeTextLabel) {
        
        _bestTimeTextLabel = [[UILabel alloc] init];
        _bestTimeTextLabel.backgroundColor = [UIColor clearColor];
        
        _bestTimeTextLabel.font = [UIFont systemFontOfSize:16.0f];
        _bestTimeTextLabel.text = NSLocalizedString(@"Label", @"Label");
        _bestTimeTextLabel.textColor = [UIColor darkTextColor];
        _bestTimeTextLabel.textAlignment = NSTextAlignmentLeft;
        _bestTimeTextLabel.numberOfLines = 0;
    }
    
    return _bestTimeTextLabel;
}

- (UILabel *)bestCountTittleLabel {
    
    if (!_bestCountTittleLabel) {
        
        _bestCountTittleLabel = [[UILabel alloc] init];
        _bestCountTittleLabel.backgroundColor = [UIColor clearColor];
        
        _bestCountTittleLabel.font = [UIFont systemFontOfSize:16.0f];
        _bestCountTittleLabel.text = NSLocalizedString(@"Label", @"Label");
        _bestCountTittleLabel.textColor = [UIColor darkTextColor];
        _bestCountTittleLabel.textAlignment = NSTextAlignmentLeft;
        _bestCountTittleLabel.numberOfLines = 0;
    }
    
    return _bestCountTittleLabel;
}

- (UILabel *)bestCountTextLabel {
    
    if (!_bestCountTextLabel) {
        
        _bestCountTextLabel = [[UILabel alloc] init];
        _bestCountTextLabel.backgroundColor = [UIColor clearColor];
        
        _bestCountTextLabel.font = [UIFont systemFontOfSize:16.0f];
        _bestCountTextLabel.text = NSLocalizedString(@"Label", @"Label");
        _bestCountTextLabel.textColor = [UIColor darkTextColor];
        _bestCountTextLabel.textAlignment = NSTextAlignmentLeft;
        _bestCountTextLabel.numberOfLines = 0;
    }
    
    return _bestCountTextLabel;
}

- (UIView *)currentBackgroundView {
    
    if (!_currentBackgroundView) {
        
        _currentBackgroundView = [[UIView alloc] init];
        _currentBackgroundView.backgroundColor = [UIColor qh_randomColor];
        
        _currentBackgroundView.layer.cornerRadius = 0.0f;
        _currentBackgroundView.layer.masksToBounds = YES;
    }
    
    return _currentBackgroundView;
}

- (UILabel *)currentTimeTitleLabel {
    
    if (!_currentTimeTitleLabel) {
        
        _currentTimeTitleLabel = [[UILabel alloc] init];
        _currentTimeTitleLabel.backgroundColor = [UIColor clearColor];
        
        _currentTimeTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _currentTimeTitleLabel.text = NSLocalizedString(@"Label", @"Label");
        _currentTimeTitleLabel.textColor = [UIColor darkTextColor];
        _currentTimeTitleLabel.textAlignment = NSTextAlignmentLeft;
        _currentTimeTitleLabel.numberOfLines = 0;
    }
    
    return _currentTimeTitleLabel;
}

- (UILabel *)currentTimeTextLabel {
    
    if (!_currentTimeTextLabel) {
        
        _currentTimeTextLabel = [[UILabel alloc] init];
        _currentTimeTextLabel.backgroundColor = [UIColor clearColor];
        
        _currentTimeTextLabel.font = [UIFont systemFontOfSize:16.0f];
        _currentTimeTextLabel.text = NSLocalizedString(@"Label", @"Label");
        _currentTimeTextLabel.textColor = [UIColor darkTextColor];
        _currentTimeTextLabel.textAlignment = NSTextAlignmentLeft;
        _currentTimeTextLabel.numberOfLines = 0;
    }
    
    return _currentTimeTextLabel;
}

- (UILabel *)currentCountTittleLabel {
    
    if (!_currentCountTittleLabel) {
        
        _currentCountTittleLabel = [[UILabel alloc] init];
        _currentCountTittleLabel.backgroundColor = [UIColor clearColor];
        
        _currentCountTittleLabel.font = [UIFont systemFontOfSize:16.0f];
        _currentCountTittleLabel.text = NSLocalizedString(@"Label", @"Label");
        _currentCountTittleLabel.textColor = [UIColor darkTextColor];
        _currentCountTittleLabel.textAlignment = NSTextAlignmentLeft;
        _currentCountTittleLabel.numberOfLines = 0;
    }
    
    return _currentCountTittleLabel;
}

- (UILabel *)currentCountTextLabel {
    
    if (!_currentCountTextLabel) {
        
        _currentCountTextLabel = [[UILabel alloc] init];
        _currentCountTextLabel.backgroundColor = [UIColor clearColor];
        
        _currentCountTextLabel.font = [UIFont systemFontOfSize:16.0f];
        _currentCountTextLabel.text = NSLocalizedString(@"Label", @"Label");
        _currentCountTextLabel.textColor = [UIColor darkTextColor];
        _currentCountTextLabel.textAlignment = NSTextAlignmentLeft;
        _currentCountTextLabel.numberOfLines = 0;
    }
    
    return _currentCountTextLabel;
}

- (UIView *)gameboardBackgroundView {
    
    if (!_gameboardBackgroundView) {
        
        _gameboardBackgroundView = [[UIView alloc] init];
        _gameboardBackgroundView.backgroundColor = [UIColor qh_randomColor];
        
        _gameboardBackgroundView.layer.cornerRadius = 0.0f;
        _gameboardBackgroundView.layer.masksToBounds = YES;
    }
    
    return _gameboardBackgroundView;
}

- (UIView *)gameboardView {
    
    if (!_gameboardView) {
        
        _gameboardView = [[UIView alloc] init];
        _gameboardView.backgroundColor = [UIColor qh_randomColor];
        
        _gameboardView.layer.cornerRadius = 0.0f;
        _gameboardView.layer.masksToBounds = YES;
    }
    
    return _gameboardView;
}

@end
