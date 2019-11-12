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

/**
 容器视图
 */
@property (nonatomic, strong) UIView *containerView;

/**
 返回按钮
 */
@property (nonatomic, strong) UIButton *backButton;

/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

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
    
    // 容器视图
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(self.qh_statusBarHeight + 100.0f);
    }];
    
    // 返回按钮
    [self.containerView addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.containerView).with.inset(self.qh_statusBarHeight);
        make.left.mas_equalTo(self.containerView).with.inset(20.0f);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];
    
    // 标题
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.backButton.mas_bottom);
        make.left.and.right.mas_equalTo(self.containerView).with.inset(20.0f);
        make.bottom.mas_equalTo(self.containerView);
    }];
    
    // 集合视图
    [self addSubview:self.qh_tableView];
    [self.qh_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.containerView.mas_bottom).with.inset(5.0f);
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod
- (IBAction)didClickBackButton:(id)sender {
    NSLog(@"返回首页");
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_popToRoot)]) {
        
        [self.qh_delegate qh_popToRoot];
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

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor qh_randomColor];
        
        _containerView.layer.cornerRadius = 0.0f;
        _containerView.layer.masksToBounds = YES;
    }
    
    return _containerView;
}

- (UIButton *)backButton {
    
    if (!_backButton) {
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor qh_randomColor];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_backButton setImage:nil forState:UIControlStateNormal];
        [_backButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_backButton setTitle:NSLocalizedString(@"back", @"Button") forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(didClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _backButton.layer.cornerRadius = 0.0f;
        _backButton.layer.masksToBounds = YES;
    }
    
    return _backButton;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor qh_randomColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:28.0f];
        _titleLabel.text = NSLocalizedString(@"选择游戏等级", @"Label");
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

@end


#pragma mark -

@interface GQHLevelsViewTableViewCell ()

/**
 容器视图
 */
@property (nonatomic, strong) UIView *containerView;

/**
 等级标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 等级阶数
 */
@property (nonatomic, strong) UILabel *orderLabel;

/**
 等级说明
 */
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation GQHLevelsViewTableViewCell

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHLevelsViewTableViewCell";
    GQHLevelsViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHLevelsViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    // 容器视图
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.contentView).with.inset(20.0f);
        make.top.and.bottom.mas_equalTo(self.contentView).with.inset(5.0f);
    }];
    
    // 等级阶数
    [self.containerView addSubview:self.orderLabel];
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.right.mas_equalTo(self.containerView).with.inset(10.0f);
        make.size.mas_equalTo(CGSizeMake(44.0f, 44.0f));
    }];
    
    // 等级标题
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.mas_equalTo(self.containerView).with.inset(10.0f);
        make.right.mas_equalTo(self.orderLabel.mas_left).with.inset(10.0f);
        make.height.mas_equalTo(44.0f);
    }];
    
    // 等级说明
    [self.containerView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.inset(10.0f);
        make.left.and.right.and.bottom.mas_equalTo(self.containerView).with.inset(10.0f);
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
        
        self.titleLabel.text = [data objectForKey:@"title"];
        self.orderLabel.text = [data objectForKey:@"order"];
        self.detailLabel.text = [data objectForKey:@"detail"];
    }
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
        _containerView.backgroundColor = [UIColor qh_randomColor];
        
        _containerView.layer.cornerRadius = 0.0f;
        _containerView.layer.masksToBounds = YES;
    }
    
    return _containerView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor qh_randomColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:28.0f];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 1;
    }
    
    return _titleLabel;
}

- (UILabel *)orderLabel {
    
    if (!_orderLabel) {
        
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.backgroundColor = [UIColor qh_randomColor];
        
        _orderLabel.font = [UIFont systemFontOfSize:18.0f];
        _orderLabel.textColor = [UIColor redColor];
        _orderLabel.textAlignment = NSTextAlignmentCenter;
        _orderLabel.numberOfLines = 1;
    }
    
    return _orderLabel;
}

- (UILabel *)detailLabel {
    
    if (!_detailLabel) {
        
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.backgroundColor = [UIColor qh_randomColor];
        
        _detailLabel.font = [UIFont systemFontOfSize:16.0f];
        _detailLabel.textColor = [UIColor darkTextColor];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 1;
    }
    
    return _detailLabel;
}

@end


#pragma mark -

@interface GQHLevelsViewTableViewHeaderView ()

@end

@implementation GQHLevelsViewTableViewHeaderView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的头视图
 
 @param tableView 列表视图
 @param data 列表头视图数据
 @return 自定义头视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView headerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHLevelsViewTableViewHeaderView";
    GQHLevelsViewTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        
        headerView = [[GQHLevelsViewTableViewHeaderView alloc] initWithReuseIdentifier:identifier];
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

@interface GQHLevelsViewTableViewFooterView ()

@end

@implementation GQHLevelsViewTableViewFooterView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的尾视图
 
 @param tableView 列表视图
 @param data 列表尾视图数据
 @return 自定义尾视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView footerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHLevelsViewTableViewFooterView";
    GQHLevelsViewTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!footerView) {
        
        footerView = [[GQHLevelsViewTableViewFooterView alloc] initWithReuseIdentifier:identifier];
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
