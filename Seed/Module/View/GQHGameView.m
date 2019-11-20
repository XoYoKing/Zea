//
//  GQHGameView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHGameView.h"
#import "GQHHeader.h"
#import "GQHRecordModel.h"


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
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight + self.qh_navigationBarHeight + GQHSpacing);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5f * self.qh_contentAreaWidth);
    }];
    
    // 图片预览视图
    [self.scoreboardBackgroundView addSubview:self.previewImageView];
    [self.previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.bottom.mas_equalTo(self.scoreboardBackgroundView).with.inset(GQHSpacing);
        make.width.mas_equalTo(self.previewImageView.mas_height).with.multipliedBy(1.0f);
    }];
    
    // 最佳记录背景视图
    [self.scoreboardBackgroundView addSubview:self.bestBackgroundView];
    [self.bestBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.right.mas_equalTo(self.scoreboardBackgroundView).with.inset(GQHSpacing);
        make.left.mas_equalTo(self.previewImageView.mas_right).with.inset(GQHSpacing);
        make.height.mas_greaterThanOrEqualTo(CGFLOAT_MIN);
    }];
    
    // 最佳时间标题
    [self.bestBackgroundView addSubview:self.bestTimeTitleLabel];
    [self.bestTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.mas_equalTo(self.bestBackgroundView);
        make.height.mas_equalTo(self.bestBackgroundView.mas_height).with.multipliedBy(0.5f);
        make.width.mas_greaterThanOrEqualTo(CGFLOAT_MIN);
    }];
    
    // 最佳时间
    [self.bestBackgroundView addSubview:self.bestTimeTextLabel];
    [self.bestTimeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.right.mas_equalTo(self.bestBackgroundView);
        make.left.mas_equalTo(self.bestTimeTitleLabel.mas_right).with.inset(GQHSpacing);
        make.height.mas_equalTo(self.bestTimeTitleLabel);
        make.width.mas_equalTo(self.bestTimeTitleLabel.mas_width);
    }];
    
    // 最佳计数标题
    [self.bestBackgroundView addSubview:self.bestCountTittleLabel];
    [self.bestCountTittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.and.left.mas_equalTo(self.bestBackgroundView);
        make.height.mas_equalTo(self.bestBackgroundView.mas_height).with.multipliedBy(0.5f);
        make.width.mas_greaterThanOrEqualTo(CGFLOAT_MIN);
    }];
    
    // 最佳计数
    [self.bestBackgroundView addSubview:self.bestCountTextLabel];
    [self.bestCountTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.and.right.mas_equalTo(self.bestBackgroundView);
        make.left.mas_equalTo(self.bestCountTittleLabel.mas_right).with.inset(GQHSpacing);
        make.height.mas_equalTo(self.bestCountTittleLabel);
        make.width.mas_equalTo(self.bestCountTittleLabel.mas_width);
    }];
    
    // 当前记录背景视图
    [self.scoreboardBackgroundView addSubview:self.currentBackgroundView];
    [self.currentBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bestBackgroundView.mas_bottom).with.inset(GQHSpacing);
        make.bottom.and.right.mas_equalTo(self.scoreboardBackgroundView).with.inset(GQHSpacing);
        make.left.mas_equalTo(self.previewImageView.mas_right).with.inset(GQHSpacing);
        make.height.mas_equalTo(self.bestBackgroundView);
    }];
    
    // 当前时间标题
    [self.currentBackgroundView addSubview:self.currentTimeTitleLabel];
    [self.currentTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.mas_equalTo(self.currentBackgroundView);
        make.height.mas_equalTo(self.currentBackgroundView.mas_height).with.multipliedBy(0.5f);
        make.width.mas_greaterThanOrEqualTo(CGFLOAT_MIN);
    }];
    
    // 当前时间
    [self.currentBackgroundView addSubview:self.currentTimeTextLabel];
    [self.currentTimeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.right.mas_equalTo(self.currentBackgroundView);
        make.left.mas_equalTo(self.currentTimeTitleLabel.mas_right).with.inset(GQHSpacing);
        make.height.mas_equalTo(self.currentTimeTitleLabel);
        make.width.mas_equalTo(self.currentTimeTitleLabel.mas_width);
    }];
    
    // 当前计数标题
    [self.currentBackgroundView addSubview:self.currentCountTittleLabel];
    [self.currentCountTittleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.and.left.mas_equalTo(self.currentBackgroundView);
        make.height.mas_equalTo(self.currentBackgroundView.mas_height).with.multipliedBy(0.5f);
        make.width.mas_greaterThanOrEqualTo(CGFLOAT_MIN);
    }];
    
    // 当前计数
    [self.currentBackgroundView addSubview:self.currentCountTextLabel];
    [self.currentCountTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.and.right.mas_equalTo(self.currentBackgroundView);
        make.left.mas_equalTo(self.currentCountTittleLabel.mas_right).with.inset(GQHSpacing);
        make.height.mas_equalTo(self.currentCountTittleLabel);
        make.width.mas_equalTo(self.currentCountTittleLabel.mas_width);
    }];
    
    //MARK: 游戏板(gameboard)
    // 游戏板背景视图
    [self addSubview:self.gameboardBackgroundView];
    [self.gameboardBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.scoreboardBackgroundView.mas_bottom).with.inset(GQHSpacing);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(self.gameboardBackgroundView.mas_width).with.multipliedBy(1.0f);
    }];
    
    // 游戏板视图
    [self.gameboardBackgroundView addSubview:self.qh_gameboardView];
    [self.qh_gameboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.gameboardBackgroundView).with.insets(UIEdgeInsetsMake(GQHSpacing, GQHSpacing, GQHSpacing, GQHSpacing));
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
    
    if (data) {
           
           GQHRecordModel *record = (GQHRecordModel *)data;
           
           // 游戏用时
           NSInteger hours = record.qh_gameTime/3600;
           NSInteger minutes = (record.qh_gameTime%3600)/60;
           NSInteger seconds = record.qh_gameTime%60;
           self.currentTimeTextLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];
           
           // 游戏计数
           self.currentCountTextLabel.text = [NSString stringWithFormat:@"%ld",record.qh_gameCount];
       }
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
        
        // 本地游戏图片
        NSString *imageName = [NSUserDefaults.standardUserDefaults objectForKey:GQHGameImageKey];
        _previewImageView.image = [UIImage imageNamed:imageName];
        
        _previewImageView.layer.cornerRadius = 2.0f;
        _previewImageView.layer.masksToBounds = YES;
    }
    
    return _previewImageView;
}

- (UIView *)bestBackgroundView {
    
    if (!_bestBackgroundView) {
        
        _bestBackgroundView = [[UIView alloc] init];
        _bestBackgroundView.backgroundColor = [UIColor qh_colorWithHexString:@"#EC8C7A"];
        
        _bestBackgroundView.layer.cornerRadius = 2.0f;
        _bestBackgroundView.layer.masksToBounds = YES;
    }
    
    return _bestBackgroundView;
}

- (UILabel *)bestTimeTitleLabel {
    
    if (!_bestTimeTitleLabel) {
        
        _bestTimeTitleLabel = [[UILabel alloc] init];
        _bestTimeTitleLabel.backgroundColor = [UIColor clearColor];
        
        _bestTimeTitleLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _bestTimeTitleLabel.text = NSLocalizedString(@"best", @"标题");
        _bestTimeTitleLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _bestTimeTitleLabel.textAlignment = NSTextAlignmentRight;
        _bestTimeTitleLabel.numberOfLines = 1;
    }
    
    return _bestTimeTitleLabel;
}

- (UILabel *)bestTimeTextLabel {
    
    if (!_bestTimeTextLabel) {
        
        _bestTimeTextLabel = [[UILabel alloc] init];
        _bestTimeTextLabel.backgroundColor = [UIColor clearColor];
        
        _bestTimeTextLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _bestTimeTextLabel.text = NSLocalizedString(@"00:38:20", @"");
        _bestTimeTextLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _bestTimeTextLabel.textAlignment = NSTextAlignmentLeft;
        _bestTimeTextLabel.numberOfLines = 1;
    }
    
    return _bestTimeTextLabel;
}

- (UILabel *)bestCountTittleLabel {
    
    if (!_bestCountTittleLabel) {
        
        _bestCountTittleLabel = [[UILabel alloc] init];
        _bestCountTittleLabel.backgroundColor = [UIColor clearColor];
        
        _bestCountTittleLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _bestCountTittleLabel.text = NSLocalizedString(@"least", @"标题");
        _bestCountTittleLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _bestCountTittleLabel.textAlignment = NSTextAlignmentRight;
        _bestCountTittleLabel.numberOfLines = 1;
    }
    
    return _bestCountTittleLabel;
}

- (UILabel *)bestCountTextLabel {
    
    if (!_bestCountTextLabel) {
        
        _bestCountTextLabel = [[UILabel alloc] init];
        _bestCountTextLabel.backgroundColor = [UIColor clearColor];
        
        _bestCountTextLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _bestCountTextLabel.text = NSLocalizedString(@"929939", @"");
        _bestCountTextLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _bestCountTextLabel.textAlignment = NSTextAlignmentLeft;
        _bestCountTextLabel.numberOfLines = 1;
    }
    
    return _bestCountTextLabel;
}

- (UIView *)currentBackgroundView {
    
    if (!_currentBackgroundView) {
        
        _currentBackgroundView = [[UIView alloc] init];
        _currentBackgroundView.backgroundColor = [UIColor qh_colorWithHexString:@"#EC8C7A"];
        
        _currentBackgroundView.layer.cornerRadius = 2.0f;
        _currentBackgroundView.layer.masksToBounds = YES;
    }
    
    return _currentBackgroundView;
}

- (UILabel *)currentTimeTitleLabel {
    
    if (!_currentTimeTitleLabel) {
        
        _currentTimeTitleLabel = [[UILabel alloc] init];
        _currentTimeTitleLabel.backgroundColor = [UIColor clearColor];
        
        _currentTimeTitleLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _currentTimeTitleLabel.text = NSLocalizedString(@"time", @"标题");
        _currentTimeTitleLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _currentTimeTitleLabel.textAlignment = NSTextAlignmentRight;
        _currentTimeTitleLabel.numberOfLines = 1;
    }
    
    return _currentTimeTitleLabel;
}

- (UILabel *)currentTimeTextLabel {
    
    if (!_currentTimeTextLabel) {
        
        _currentTimeTextLabel = [[UILabel alloc] init];
        _currentTimeTextLabel.backgroundColor = [UIColor clearColor];
        
        _currentTimeTextLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _currentTimeTextLabel.text = NSLocalizedString(@"00:29:38", @"");
        _currentTimeTextLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _currentTimeTextLabel.textAlignment = NSTextAlignmentLeft;
        _currentTimeTextLabel.numberOfLines = 1;
    }
    
    return _currentTimeTextLabel;
}

- (UILabel *)currentCountTittleLabel {
    
    if (!_currentCountTittleLabel) {
        
        _currentCountTittleLabel = [[UILabel alloc] init];
        _currentCountTittleLabel.backgroundColor = [UIColor clearColor];
        
        _currentCountTittleLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _currentCountTittleLabel.text = NSLocalizedString(@"count", @"");
        _currentCountTittleLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _currentCountTittleLabel.textAlignment = NSTextAlignmentRight;
        _currentCountTittleLabel.numberOfLines = 1;
    }
    
    return _currentCountTittleLabel;
}

- (UILabel *)currentCountTextLabel {
    
    if (!_currentCountTextLabel) {
        
        _currentCountTextLabel = [[UILabel alloc] init];
        _currentCountTextLabel.backgroundColor = [UIColor clearColor];
        
        _currentCountTextLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:18.0f];
        _currentCountTextLabel.text = NSLocalizedString(@"182382", @"");
        _currentCountTextLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkBlack];
        _currentCountTextLabel.textAlignment = NSTextAlignmentLeft;
        _currentCountTextLabel.numberOfLines = 1;
    }
    
    return _currentCountTextLabel;
}

- (UIView *)gameboardBackgroundView {
    
    if (!_gameboardBackgroundView) {
        
        _gameboardBackgroundView = [[UIView alloc] init];
        _gameboardBackgroundView.backgroundColor = [UIColor whiteColor];
        
        _gameboardBackgroundView.layer.cornerRadius = 0.0f;
        _gameboardBackgroundView.layer.masksToBounds = YES;
    }
    
    return _gameboardBackgroundView;
}

- (UIView *)qh_gameboardView {
    
    if (!_qh_gameboardView) {
        
        _qh_gameboardView = [[UIView alloc] init];
        _qh_gameboardView.backgroundColor = [UIColor qh_colorWithHexString:@"#A8A8A8"];
        
        _qh_gameboardView.layer.cornerRadius = 2.0f;
        _qh_gameboardView.layer.masksToBounds = YES;
    }
    
    return _qh_gameboardView;
}

@end
