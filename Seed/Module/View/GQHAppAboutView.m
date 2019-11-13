//
//  GQHAppAboutView.h
//
//  Created by GuanQinghao on 2019-08-11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import "GQHAppAboutView.h"
#import "GQHHeader.h"


#pragma mark -

@interface GQHAppAboutView ()

/**
 容器视图
 */
@property (nonatomic, strong) UIView *containerView;

/**
 图标视图
 */
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 应用名称
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 版本信息
 */
@property (nonatomic, strong) UILabel *versionLabel;

/**
 版权信息
 */
@property (nonatomic, strong) UILabel *copyrightLabel;

@end

@implementation GQHAppAboutView

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
    
    // 容器视图
    [self addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight + self.qh_navigationBarHeight + 10.0f);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(120.0f);
    }];
    
    //MARK: app
    // 版权信息
    [self.containerView addSubview:self.copyrightLabel];
    [self.copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.containerView).with.inset(10.0f);
        make.bottom.mas_equalTo(self.containerView);
        make.height.mas_equalTo(20.0f);
    }];
    
    // 图标视图
    [self.containerView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.copyrightLabel.mas_top).with.inset(10.0f);
        make.left.mas_equalTo(self.containerView).with.inset(10.0f);
        make.size.mas_equalTo(CGSizeMake(60.0f, 60.0f));
    }];
    
    // 应用名称
    [self.containerView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).with.inset(10.0f);
        make.right.mas_equalTo(self.containerView).with.inset(10.0f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 版本信息
    [self.containerView addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).with.inset(10.0f);
        make.right.mas_equalTo(self.containerView).with.inset(10.0f);
        make.height.mas_equalTo(30.0f);
    }];
    
    // 列表视图
    [self addSubview:self.qh_tableView];
    [self.qh_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.containerView.mas_bottom).with.inset(10.0f);
        make.left.and.right.mas_equalTo(self);
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

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor whiteColor];
        
        _iconImageView.image = [UIImage imageNamed:@"iconstore_1024pt"];
        
        _iconImageView.layer.cornerRadius = 2.0f;
        _iconImageView.layer.masksToBounds = YES;
    }
    
    return _iconImageView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor whiteColor];
        
        _nameLabel.font = [UIFont systemFontOfSize:20.0f];
        _nameLabel.text = UIApplication.sharedApplication.qh_applicationDisplayName;
        _nameLabel.textColor = [UIColor darkTextColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.numberOfLines = 1;
    }
    
    return _nameLabel;
}

- (UILabel *)versionLabel {
    
    if (!_versionLabel) {
        
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.backgroundColor = [UIColor whiteColor];
        
        _versionLabel.font = [UIFont systemFontOfSize:18.0f];
        _versionLabel.text = [NSString stringWithFormat:@"v %@",UIApplication.sharedApplication.qh_applicationShortVersion];
        _versionLabel.textColor = [UIColor darkTextColor];
        _versionLabel.textAlignment = NSTextAlignmentLeft;
        _versionLabel.numberOfLines = 1;
    }
    
    return _versionLabel;
}

- (UILabel *)copyrightLabel {
    
    if (!_copyrightLabel) {
        
        _copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel.backgroundColor = [UIColor whiteColor];
        
        _copyrightLabel.font = [UIFont systemFontOfSize:16.0f];
        _copyrightLabel.text = NSLocalizedString(@"Copyright © 2016-2019 Guan Qinghao. All rights reserved.", @"Label");
        _copyrightLabel.textColor = [UIColor darkTextColor];
        _copyrightLabel.textAlignment = NSTextAlignmentLeft;
        _copyrightLabel.numberOfLines = 1;
    }
    
    return _copyrightLabel;
}

@end


#pragma mark -

@interface GQHAppAboutTableViewCell ()

@end

@implementation GQHAppAboutTableViewCell

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHAppAboutTableViewCell";
    GQHAppAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHAppAboutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

@interface GQHAppAboutTableViewHeaderView ()

@end

@implementation GQHAppAboutTableViewHeaderView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的头视图
 
 @param tableView 列表视图
 @param data 列表头视图数据
 @return 自定义头视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView headerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHAppAboutTableViewHeaderView";
    GQHAppAboutTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        
        headerView = [[GQHAppAboutTableViewHeaderView alloc] initWithReuseIdentifier:identifier];
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

@interface GQHAppAboutTableViewFooterView ()

@end

@implementation GQHAppAboutTableViewFooterView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的尾视图
 
 @param tableView 列表视图
 @param data 列表尾视图数据
 @return 自定义尾视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView footerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHAppAboutTableViewFooterView";
    GQHAppAboutTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!footerView) {
        
        footerView = [[GQHAppAboutTableViewFooterView alloc] initWithReuseIdentifier:identifier];
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
