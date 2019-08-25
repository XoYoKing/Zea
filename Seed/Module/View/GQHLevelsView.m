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
 等级菜单
 */
@property (nonatomic, strong) UIStackView *menusView;

/**
 3X3
 */
@property (nonatomic, strong) UIButton *x3Button;

/**
 4X4
 */
@property (nonatomic, strong) UIButton *x4Button;

/**
 5X5
 */
@property (nonatomic, strong) UIButton *x5Button;

/**
 6X6
 */
@property (nonatomic, strong) UIButton *x6Button;

/**
 8X8
 */
@property (nonatomic, strong) UIButton *x8Button;

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
        
        // 其他初始化
        [self.menusView addSubview:self.x3Button];
        [self.menusView addSubview:self.x4Button];
        [self.menusView addSubview:self.x5Button];
        [self.menusView addSubview:self.x6Button];
        [self.menusView addSubview:self.x8Button];
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
     等级菜单
     */
    [self addSubview:self.menusView];
    [self.menusView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.inset(self.qh_statusBarHeight);
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

- (UIStackView *)menusView {
    
    if (!_menusView) {
        
        _menusView = [[UIStackView alloc] init];
    }
    
    return _menusView;
}

- (UIButton *)x3Button {
    
    if (!_x3Button) {
        
        _x3Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _x3Button.backgroundColor = [UIColor redColor];
        _x3Button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_x3Button setImage:nil forState:UIControlStateNormal];
        [_x3Button setBackgroundImage:nil forState:UIControlStateNormal];
        [_x3Button setTitle:NSLocalizedString(@"Button", @"Button") forState:UIControlStateNormal];
        [_x3Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_x3Button addTarget:self action:@selector(didClick3X3Button:) forControlEvents:UIControlEventTouchUpInside];
        
        _x3Button.layer.cornerRadius = 0.0f;
        _x3Button.layer.masksToBounds = YES;
    }
    
    return _x3Button;
}

- (UIButton *)x4Button {
    
    if (!_x4Button) {
        
        _x4Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _x4Button.backgroundColor = [UIColor redColor];
        _x4Button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_x4Button setImage:nil forState:UIControlStateNormal];
        [_x4Button setBackgroundImage:nil forState:UIControlStateNormal];
        [_x4Button setTitle:NSLocalizedString(@"Button", @"Button") forState:UIControlStateNormal];
        [_x4Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_x4Button addTarget:self action:@selector(didClick4X4Button:) forControlEvents:UIControlEventTouchUpInside];
        
        _x4Button.layer.cornerRadius = 0.0f;
        _x4Button.layer.masksToBounds = YES;
    }
    
    return _x4Button;
}

- (UIButton *)x5Button {
    
    if (!_x5Button) {
        
        _x5Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _x5Button.backgroundColor = [UIColor redColor];
        _x5Button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_x5Button setImage:nil forState:UIControlStateNormal];
        [_x5Button setBackgroundImage:nil forState:UIControlStateNormal];
        [_x5Button setTitle:NSLocalizedString(@"Button", @"Button") forState:UIControlStateNormal];
        [_x5Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_x5Button addTarget:self action:@selector(didClick5X5Button:) forControlEvents:UIControlEventTouchUpInside];
        
        _x5Button.layer.cornerRadius = 0.0f;
        _x5Button.layer.masksToBounds = YES;
    }
    
    return _x5Button;
}

- (UIButton *)x6Button {
    
    if (!_x6Button) {
        
        _x6Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _x6Button.backgroundColor = [UIColor redColor];
        _x6Button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_x6Button setImage:nil forState:UIControlStateNormal];
        [_x6Button setBackgroundImage:nil forState:UIControlStateNormal];
        [_x6Button setTitle:NSLocalizedString(@"Button", @"Button") forState:UIControlStateNormal];
        [_x6Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_x6Button addTarget:self action:@selector(didClick6X6Button:) forControlEvents:UIControlEventTouchUpInside];
        
        _x6Button.layer.cornerRadius = 0.0f;
        _x6Button.layer.masksToBounds = YES;
    }
    
    return _x6Button;
}

- (UIButton *)x8Button {
    
    if (!_x8Button) {
        
        _x8Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _x8Button.backgroundColor = [UIColor redColor];
        _x8Button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        
        [_x8Button setImage:nil forState:UIControlStateNormal];
        [_x8Button setBackgroundImage:nil forState:UIControlStateNormal];
        [_x8Button setTitle:NSLocalizedString(@"Button", @"Button") forState:UIControlStateNormal];
        [_x8Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_x8Button addTarget:self action:@selector(didClick8X8Button:) forControlEvents:UIControlEventTouchUpInside];
        
        _x8Button.layer.cornerRadius = 0.0f;
        _x8Button.layer.masksToBounds = YES;
    }
    
    return _x8Button;
}

@end


#pragma mark -

@interface GQHLevelsTableViewCell ()

@end

@implementation GQHLevelsTableViewCell

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHLevelsTableViewCell";
    GQHLevelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHLevelsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

@interface GQHLevelsTableViewHeaderView ()

@end

@implementation GQHLevelsTableViewHeaderView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的头视图
 
 @param tableView 列表视图
 @param data 列表头视图数据
 @return 自定义头视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView headerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHLevelsTableViewHeaderView";
    GQHLevelsTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!headerView) {
        
        headerView = [[GQHLevelsTableViewHeaderView alloc] initWithReuseIdentifier:identifier];
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

@interface GQHLevelsTableViewFooterView ()

@end

@implementation GQHLevelsTableViewFooterView

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的尾视图
 
 @param tableView 列表视图
 @param data 列表尾视图数据
 @return 自定义尾视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView footerViewWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHLevelsTableViewFooterView";
    GQHLevelsTableViewFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!footerView) {
        
        footerView = [[GQHLevelsTableViewFooterView alloc] initWithReuseIdentifier:identifier];
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
