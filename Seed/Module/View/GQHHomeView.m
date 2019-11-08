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

/**
 关于按钮
 */
@property (nonatomic, strong) UIButton *aboutButton;

/**
 游戏记录按钮
 */
@property (nonatomic, strong) UIButton *recordButton;

/**
 开始游戏按钮
 */
@property (nonatomic, strong) UIButton *startButton;

/**
 游戏等级按钮
 */
@property (nonatomic, strong) UIButton *levelButton;

/**
 图库按钮
 */
@property (nonatomic, strong) UIButton *galleryButton;

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
    
    /**
     关于按钮
     */
    [self addSubview:self.aboutButton];
    [self.aboutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self).with.multipliedBy(0.3f);
        make.centerY.mas_equalTo(self).with.multipliedBy(0.3f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    
    /**
     游戏记录按钮
     */
    [self addSubview:self.recordButton];
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self).with.multipliedBy(1.7f);
        make.centerY.mas_equalTo(self).with.multipliedBy(0.3f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    
    /**
     开始游戏按钮
     */
    [self addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200.0f, 200.0f));
    }];
    
    /**
     游戏等级按钮
     */
    [self addSubview:self.levelButton];
    [self.levelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self).with.multipliedBy(0.5f);
        make.centerY.mas_equalTo(self).with.multipliedBy(1.5f);
        make.size.mas_equalTo(CGSizeMake(100.0f, 100.0f));
    }];
    
    /**
     图库按钮
     */
    [self addSubview:self.galleryButton];
    [self.galleryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.mas_equalTo(self).with.multipliedBy(1.5f);
        make.centerY.mas_equalTo(self).with.multipliedBy(1.5f);
        make.size.mas_equalTo(CGSizeMake(100.0f, 100.0f));
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

/**
 点击关于按钮

 @param sender 关于按钮
 */
- (IBAction)didClickAboutButton:(UIButton *)sender {
    NSLog(@"");
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_forwardAboutUsPage)]) {
        
        [self.qh_delegate qh_forwardAboutUsPage];
    }
}

/**
 点击游戏记录按钮
 
 @param sender 游戏记录按钮
 */
- (IBAction)didClickRecordButton:(UIButton *)sender {
    NSLog(@"");
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_forwardRecordsPage)]) {
        
        [self.qh_delegate qh_forwardRecordsPage];
    }
}

/**
 点击开始游戏按钮
 
 @param sender 开始游戏按钮
 */
- (IBAction)didClickStartButton:(UIButton *)sender {
    NSLog(@"");
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_forwardGamePage)]) {
        
        [self.qh_delegate qh_forwardGamePage];
    }
}

/**
 点击游戏等级按钮
 
 @param sender 游戏等级按钮
 */
- (IBAction)didClickLevelButton:(UIButton *)sender {
    NSLog(@"");
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_forwardLevelsPage)]) {
        
        [self.qh_delegate qh_forwardLevelsPage];
    }
}

/**
 点击图库按钮
 
 @param sender 图库按钮
 */
- (IBAction)didClickGalleryButton:(UIButton *)sender {
    NSLog(@"");
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_forwardGallaryPage)]) {
        
        [self.qh_delegate qh_forwardGallaryPage];
    }
}

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
- (UITableView *)qh_tableView {
    
    if (!_qh_tableView) {
        
        _qh_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _qh_tableView.backgroundColor = [UIColor whiteColor];
        _qh_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _qh_tableView.showsVerticalScrollIndicator = NO;
        _qh_tableView.showsHorizontalScrollIndicator = NO;
        
        // 列表自动计算行高
        _qh_tableView.estimatedRowHeight = 200.0f;
        _qh_tableView.rowHeight = UITableViewAutomaticDimension;
        
        if (@available(iOS 11.0, *)) {
            
            _qh_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _qh_tableView;
}

- (UIButton *)aboutButton {
    
    if (!_aboutButton) {
        
        _aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _aboutButton.backgroundColor = [UIColor qh_colorWithHexString:GQHDarkGreen];
        _aboutButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_aboutButton setImage:nil forState:UIControlStateNormal];
        [_aboutButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_aboutButton setTitle:NSLocalizedString(@"about", @"关于") forState:UIControlStateNormal];
        [_aboutButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        [_aboutButton addTarget:self action:@selector(didClickAboutButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _aboutButton.layer.cornerRadius = 8.0f;
        _aboutButton.layer.masksToBounds = YES;
    }
    
    return _aboutButton;
}

- (UIButton *)recordButton {
    
    if (!_recordButton) {
        
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordButton.backgroundColor = [UIColor qh_colorWithHexString:GQHDarkGreen];
        _recordButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_recordButton setImage:nil forState:UIControlStateNormal];
        [_recordButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_recordButton setTitle:NSLocalizedString(@"record", @"记录") forState:UIControlStateNormal];
        [_recordButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
        [_recordButton addTarget:self action:@selector(didClickRecordButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _recordButton.layer.cornerRadius = 8.0f;
        _recordButton.layer.masksToBounds = YES;
    }
    
    return _recordButton;
}

- (UIButton *)startButton {
    
    if (!_startButton) {
        
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.backgroundColor = [UIColor qh_colorWithHexString:GQHDarkestGreen];
        _startButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_startButton setImage:nil forState:UIControlStateNormal];
        [_startButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_startButton setTitle:NSLocalizedString(@"start", @"开始") forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(didClickStartButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _startButton.layer.cornerRadius = 32.0f;
        _startButton.layer.masksToBounds = YES;
    }
    
    return _startButton;
}

- (UIButton *)levelButton {
    
    if (!_levelButton) {
        
        _levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _levelButton.backgroundColor = [UIColor qh_colorWithHexString:GQHDarkestGreen];
        _levelButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_levelButton setImage:nil forState:UIControlStateNormal];
        [_levelButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_levelButton setTitle:NSLocalizedString(@"level", @"等级") forState:UIControlStateNormal];
        [_levelButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_levelButton addTarget:self action:@selector(didClickLevelButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _levelButton.layer.cornerRadius =16.0f;
        _levelButton.layer.masksToBounds = YES;
    }
    
    return _levelButton;
}

- (UIButton *)galleryButton {
    
    if (!_galleryButton) {
        
        _galleryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _galleryButton.backgroundColor = [UIColor qh_colorWithHexString:GQHDarkestGreen];
        _galleryButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_galleryButton setImage:nil forState:UIControlStateNormal];
        [_galleryButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_galleryButton setTitle:NSLocalizedString(@"gallery", @"图库") forState:UIControlStateNormal];
        [_galleryButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_galleryButton addTarget:self action:@selector(didClickGalleryButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _galleryButton.layer.cornerRadius = 16.0f;
        _galleryButton.layer.masksToBounds = YES;
    }
    
    return _galleryButton;
}

@end


#pragma mark -

@interface GQHHomeTableViewCell ()

@end

@implementation GQHHomeTableViewCell

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHHomeTableViewCell";
    GQHHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 根据视图数据更新视图
    cell.qh_data = data;
    
    return cell;
}

/**
 初始化列表自定义行视图
 
 @param style 列表自定义行视图样式
 @param reuseIdentifier 列表行视图复用标识
 @return 列表自定义行视图
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    NSLog(@"");
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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
    
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 根据视图数据更新视图
 
 @param data 列表行视图数据
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


#pragma mark -

@interface GQHHomeTableViewHeaderView ()

@end

@implementation GQHHomeTableViewHeaderView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的头视图
 
 @param tableView 列表视图
 @param data 列表头视图数据
 @return 自定义头视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView headerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHHomeTableViewHeaderView";
    GQHHomeTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        
        headerView = [[GQHHomeTableViewHeaderView alloc] initWithReuseIdentifier:identifier];
    }
    
    // 根据视图数据更新视图
    headerView.qh_data = data;
    
    return headerView;
}

/**
 初始化列表自定义头视图
 
 @param reuseIdentifier 列表头视图复用标识
 @return 列表自定义头视图
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    NSLog(@"");
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
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
    
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 根据视图数据更新视图
 
 @param data 列表头视图数据
 */
- (void)updateHeaderViewWithData:(id)data {
    NSLog(@"");
    
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新头视图数据
    [self updateHeaderViewWithData:qh_data];
}

#pragma mark - Getter

@end


#pragma mark -

@interface GQHHomeTableViewFooterView ()

@end

@implementation GQHHomeTableViewFooterView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的尾视图
 
 @param tableView 列表视图
 @param data 列表尾视图数据
 @return 自定义尾视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView footerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHHomeTableViewFooterView";
    GQHHomeTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!footerView) {
        
        footerView = [[GQHHomeTableViewFooterView alloc] initWithReuseIdentifier:identifier];
    }
    
    // 根据视图数据更新视图
    footerView.qh_data = data;
    
    return footerView;
}

/**
 初始化列表自定义尾视图
 
 @param reuseIdentifier 列表尾视图复用标识
 @return 列表自定义尾视图
 */
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    NSLog(@"");
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
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
    
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod
/**
 根据视图数据更新视图
 
 @param data 列表尾视图数据
 */
- (void)updateFooterViewWithData:(id)data {
    NSLog(@"");
    
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新根视图数据
    [self updateFooterViewWithData:qh_data];
}

#pragma mark - Getter

@end
