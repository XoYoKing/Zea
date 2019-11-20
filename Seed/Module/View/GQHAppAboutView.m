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
 公众号二维码
 */
@property (nonatomic, strong) UIImageView *wechatImageView;

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
    
    // 图标视图
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight + self.qh_navigationBarHeight + GQHSpacing);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80.0f, 80.0f));
    }];
    
    // 应用名称
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.iconImageView.mas_bottom);
        make.width.mas_greaterThanOrEqualTo(GQHMinLayoutValue);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(40.0f);
    }];
    
    // 版本信息
    [self addSubview:self.versionLabel];
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLabel.mas_bottom);
        make.width.mas_greaterThanOrEqualTo(GQHMinLayoutValue);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(15.0f);
    }];
    
    // 版权信息
    [self addSubview:self.copyrightLabel];
    [self.copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self).with.inset(self.qh_homeIndicatorHeight);
        make.left.and.right.mas_equalTo(self).with.inset(GQHSpacing);
        make.height.mas_greaterThanOrEqualTo(GQHMinLayoutValue);
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

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor whiteColor];
        
        // app中的icon
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
        _iconImageView.image = [UIImage imageNamed:icon];
        
        _iconImageView.layer.cornerRadius = 12.0f;
        _iconImageView.layer.masksToBounds = YES;
    }
    
    return _iconImageView;
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        
        _nameLabel.font = [UIFont fontWithName:GQHFontNamePFSMedium size:20.0f];
        _nameLabel.text = UIApplication.sharedApplication.qh_applicationDisplayName;
        _nameLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorDarkGray];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.numberOfLines = 1;
    }
    
    return _nameLabel;
}

- (UILabel *)versionLabel {
    
    if (!_versionLabel) {
        
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.backgroundColor = [UIColor clearColor];
        
        _versionLabel.font = [UIFont fontWithName:GQHFontNamePFSMedium size:14.0f];
        _versionLabel.text = [NSString stringWithFormat:@"v %@",UIApplication.sharedApplication.qh_applicationShortVersion];
        _versionLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorGray];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.numberOfLines = 1;
    }
    
    return _versionLabel;
}

- (UIImageView *)wechatImageView {
    
    if (!_wechatImageView) {
        
        _wechatImageView = [[UIImageView alloc] init];
        _wechatImageView.backgroundColor = [UIColor qh_randomColor];
        
        _wechatImageView.image = [UIImage imageNamed:@""];
        
        _wechatImageView.layer.cornerRadius = 0.0f;
        _wechatImageView.layer.masksToBounds = YES;
    }
    
    return _wechatImageView;
}

- (UILabel *)copyrightLabel {
    
    if (!_copyrightLabel) {
        
        _copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel.backgroundColor = [UIColor clearColor];
        
        _copyrightLabel.font = [UIFont fontWithName:GQHFontNamePFSRegular size:12.0f];
        _copyrightLabel.text = NSLocalizedString(@"Copyright © 2016-2019 Guan Qinghao. All rights reserved.", @"版权信息");
        _copyrightLabel.textColor = [UIColor qh_colorWithHexString:GQHFontColorGray];
        _copyrightLabel.textAlignment = NSTextAlignmentCenter;
        _copyrightLabel.numberOfLines = 0;
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
