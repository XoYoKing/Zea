//
//  GQHRecordView.h
//
//  Created by GuanQinghao on 2019-11-15.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHRecordView.h"
#import "GQHHeader.h"
#import "GQHRecordModel.h"


#pragma mark -

@interface GQHRecordView ()

@end

@implementation GQHRecordView

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
    
    // 列表视图
    [self addSubview:self.qh_tableView];
    [self.qh_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight + self.qh_navigationBarHeight);
        make.left.and.right.and.bottom.mas_equalTo(self);
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
- (UITableView *)qh_tableView {
    
    if (!_qh_tableView) {
        
        _qh_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _qh_tableView.backgroundColor = [UIColor qh_colorWithHexString:@"#f8f8f8"];
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

@end


#pragma mark -

@interface GQHRecordTableViewCell ()

/**
 游戏等级
 */
@property (nonatomic, strong) UILabel *levelLabel;

/**
 游戏完成时间戳
 */
@property (nonatomic, strong) UILabel *timestampLabel;

/**
 游戏用时
 */
@property (nonatomic, strong) UILabel *timeLabel;

/**
 游戏计数
 */
@property (nonatomic, strong) UILabel *countLabel;

/**
 分割条
 */
@property (nonatomic, strong) UIView *line;

@end

@implementation GQHRecordTableViewCell

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHRecordTableViewCell";
    GQHRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.backgroundColor = UIColor.whiteColor;
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
    
    // 分割条
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(GQHLayoutMinValue);
    }];
    
    // 游戏等级
    [self.contentView addSubview:self.levelLabel];
    [self.levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.line.mas_bottom).with.inset(GQHSpacing);
        make.left.mas_equalTo(self.contentView).with.inset(GQHSingleMargin);
        make.height.mas_equalTo(50.0f);
        make.right.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    // 游戏完成时间
    [self.contentView addSubview:self.timestampLabel];
    [self.timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.contentView);
        make.left.and.right.mas_equalTo(self.levelLabel);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 游戏用时
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.levelLabel);
        make.right.mas_equalTo(self.contentView).with.inset(GQHSingleMargin);
        make.left.mas_equalTo(self.levelLabel.mas_right);
        make.height.mas_equalTo(40.0f);
    }];
    
    // 游戏计数
    [self.contentView addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.timestampLabel);
        make.left.and.right.mas_equalTo(self.timeLabel);
        make.height.mas_equalTo(40.0f);
    }];
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
    
    if (data) {
        
        GQHRecordModel *record = (GQHRecordModel *)data;
        
        // 游戏记录等级(标题)
        self.levelLabel.text = NSLocalizedString(record.qh_levelTitle, @"等级");
        
        // 游戏记录用时
        NSInteger hours = record.qh_gameTime/3600;
        NSInteger minutes = (record.qh_gameTime%3600)/60;
        NSInteger seconds = record.qh_gameTime%60;
        self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];
        
        // 游戏记录计数
        self.countLabel.text = [NSString stringWithFormat:@"%ld",record.qh_gameCount];
        
        // 游戏记录创建时间戳
        NSString *date = [NSDate qh_formatterDateStringWithTimeStamp:record.qh_timestamp formatter:GQHDateTimeFormatterTypeHyphen];
        self.timestampLabel.text = date;
    }
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新cell的数据
    [self updateCellWithData:qh_data];
}

#pragma mark - Getter

- (UILabel *)levelLabel {
    
    if (!_levelLabel) {
        
        _levelLabel = [[UILabel alloc] init];
        _levelLabel.backgroundColor = [UIColor whiteColor];
        
        _levelLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:24.0f];
        _levelLabel.text = NSLocalizedString(@"宗师", @"Label");
        _levelLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkGray];
        _levelLabel.textAlignment = NSTextAlignmentLeft;
        _levelLabel.numberOfLines = 1;
    }
    
    return _levelLabel;
}

- (UILabel *)timestampLabel {
    
    if (!_timestampLabel) {
        
        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.backgroundColor = [UIColor whiteColor];
        
        _timestampLabel.font = [UIFont fontWithName:GQHFontNamePFSRegular size:14.0f];
        _timestampLabel.text = NSLocalizedString(@"2019-11-13 14:47:38", @"Label");
        _timestampLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorGray];
        _timestampLabel.textAlignment = NSTextAlignmentLeft;
        _timestampLabel.numberOfLines = 1;
    }
    
    return _timestampLabel;
}

- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor whiteColor];
        
        _timeLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:20.0f];
        _timeLabel.text = NSLocalizedString(@"00:23:39", @"Label");
        _timeLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkGray];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.numberOfLines = 0;
    }
    
    return _timeLabel;
}

- (UILabel *)countLabel {
    
    if (!_countLabel) {
        
        _countLabel = [[UILabel alloc] init];
        _countLabel.backgroundColor = [UIColor whiteColor];
        
        _countLabel.font = [UIFont fontWithName:GQHFontNamePFSSemibold size:20.0f];
        _countLabel.text = NSLocalizedString(@"999999", @"Label");
        _countLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkGray];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.numberOfLines = 1;
    }
    
    return _countLabel;
}

- (UIView *)line {
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor qh_colorWithHexString:@"#f8f8f8"];
        
        _line.layer.cornerRadius = 0.0f;
        _line.layer.masksToBounds = YES;
    }
    
    return _line;
}

@end


#pragma mark -

@interface GQHRecordTableViewHeaderView ()

@end

@implementation GQHRecordTableViewHeaderView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的头视图
 
 @param tableView 列表视图
 @param data 列表头视图数据
 @return 自定义头视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView headerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHRecordTableViewHeaderView";
    GQHRecordTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        
        headerView = [[GQHRecordTableViewHeaderView alloc] initWithReuseIdentifier:identifier];
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

@interface GQHRecordTableViewFooterView ()

@end

@implementation GQHRecordTableViewFooterView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的尾视图
 
 @param tableView 列表视图
 @param data 列表尾视图数据
 @return 自定义尾视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView footerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHRecordTableViewFooterView";
    GQHRecordTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!footerView) {
        
        footerView = [[GQHRecordTableViewFooterView alloc] initWithReuseIdentifier:identifier];
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
