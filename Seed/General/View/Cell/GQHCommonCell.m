//
//  GQHCommonCell.m
//  Seed
//
//  Created by GuanQinghao on 03/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHCommonCell.h"
#import "GQHHeader.h"


/// 单倍边距
CGFloat const kCellSingleMargin = 8.0f;
/// 双倍边距
CGFloat const kCellDoubleMargin = 2 * kCellSingleMargin;

#pragma mark -

@interface GQHCommonSingleTextCell ()

/**
 文本框
 */
@property (nonatomic, strong) UILabel *aTextLabel;

/**
 分割线
 */
@property (nonatomic, strong) UIView *line;

@end

@implementation GQHCommonSingleTextCell

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHCommonSingleTextCell";
    GQHCommonSingleTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHCommonSingleTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    // 文本框
    [self.contentView addSubview:self.aTextLabel];
    [self.aTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0.0f, kCellSingleMargin, 0.0f, kCellSingleMargin));
        make.size.mas_greaterThanOrEqualTo(CGSizeZero);
    }];
    
    // 分割线
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self).with.inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(GQHLineWidth);
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
    
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新cell的数据
    [self updateCellWithData:qh_data];
}

#pragma mark - Getter
- (UILabel *)aTextLabel {
    
    if (!_aTextLabel) {
        
        _aTextLabel = [[UILabel alloc] init];
        _aTextLabel.backgroundColor = [UIColor whiteColor];
        
        _aTextLabel.font = [UIFont systemFontOfSize:14.0f];
        _aTextLabel.text = NSLocalizedString(@"Label", @"Label");
        _aTextLabel.textColor = [UIColor darkTextColor];
        _aTextLabel.textAlignment = NSTextAlignmentLeft;
        _aTextLabel.numberOfLines = 0;
    }
    
    return _aTextLabel;
}

- (UIView *)line {
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor qh_lightStrokeColor];
        
        _line.layer.cornerRadius = 0.0f;
        _line.layer.masksToBounds = YES;
    }
    
    return _line;
}

@end


#pragma mark -

@interface GQHCommonSingleInputTextCell ()

/**
 单行输入框
 */
@property (nonatomic, strong) UITextField *contentTextField;

/**
 分割线
 */
@property (nonatomic, strong) UIView *line;

@end

@implementation GQHCommonSingleInputTextCell

#pragma mark - Lifecycle
/**
 根据视图数据创建列表视图的行视图
 
 @param tableView 列表视图
 @param data 列表行视图数据
 @return 自定义行视图
 */
+ (instancetype)qh_tableView:(UITableView *)tableView cellWithData:(id)data {
    NSLog(@"");
    
    static NSString *identifier = @"GQHCommonSingleInputTextCell";
    GQHCommonSingleInputTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[GQHCommonSingleInputTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    // 输入框
    [self.contentView addSubview:self.contentTextField];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0.0f, kCellSingleMargin, 0.0f, kCellSingleMargin));
    }];
    
    // 分割线
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self).with.inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(GQHLineWidth);
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
    
}

#pragma mark - Setter
- (void)setQh_data:(id)qh_data {
    
    _qh_data = qh_data;
    
    // 更新cell的数据
    [self updateCellWithData:qh_data];
}

#pragma mark - Getter
- (UITextField *)contentTextField {
    
    if (!_contentTextField) {
        
        _contentTextField = [[UITextField alloc] init];
        _contentTextField.backgroundColor = [UIColor whiteColor];
        
        _contentTextField.font = [UIFont systemFontOfSize:14.0f];
        _contentTextField.placeholder = NSLocalizedString(@"TextFieldPlaceholder", @"TextFieldPlaceholder");
        _contentTextField.text = NSLocalizedString(@"TextField", @"TextField");
        _contentTextField.textColor = [UIColor darkTextColor];
        _contentTextField.textAlignment = NSTextAlignmentLeft;
        _contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _contentTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
    return _contentTextField;
}

- (UIView *)line {
    
    if (!_line) {
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor qh_lightStrokeColor];
        
        _line.layer.cornerRadius = 0.0f;
        _line.layer.masksToBounds = YES;
    }
    
    return _line;
}

@end





#pragma mark -

@interface GQHCommonTextDoubleHorizontalCell ()

@end

@implementation GQHCommonTextDoubleHorizontalCell

#pragma mark - Lifecycle
/**
 初始化列表行视图
 
 @param style 行视图样式
 @param reuseIdentifier 重用标识
 @return 自定义行视图
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
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
 自动布局子视图 -> 约束(mas_make只有一次,自动约束，不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
    // 左文本框
    [self.contentView addSubview:self.qh_leftLabel];
    [self.qh_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    // 右文本框
    [self.contentView addSubview:self.qh_rightLabel];
    [self.qh_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    // 分割线
    [self addSubview:self.qh_line];
    [self.qh_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self).with.inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.75f);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

#pragma mark - Setter

#pragma mark - Getter
- (UILabel *)qh_leftLabel {
    
    if (!_qh_leftLabel) {
        
        _qh_leftLabel = [[UILabel alloc] init];
        _qh_leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _qh_leftLabel;
}

- (UILabel *)qh_rightLabel {
    
    if (!_qh_rightLabel) {
        
        _qh_rightLabel = [[UILabel alloc] init];
        _qh_rightLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _qh_rightLabel;
}

- (UIView *)qh_line {
    
    if (!_qh_line) {
        
        _qh_line = [[UIView alloc] init];
        _qh_line.backgroundColor = UIColor.qh_lightStrokeColor;
    }
    
    return _qh_line;
}

@end


#pragma mark -

@interface GQHCommonTextDoubleVerticalCell ()

@end

@implementation GQHCommonTextDoubleVerticalCell

#pragma mark - Lifecycle
/**
 初始化列表行视图
 
 @param style 行视图样式
 @param reuseIdentifier 重用标识
 @return 自定义行视图
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
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
 自动布局子视图 -> 约束(mas_make只有一次,自动约束，不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
    // 上文本框
    [self.contentView addSubview:self.qh_upLabel];
    [self.qh_upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.mas_equalTo(self.contentView).inset(kCellSingleMargin);
        make.right.mas_lessThanOrEqualTo(self.contentView).inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    // 下文本框
    [self.contentView addSubview:self.qh_downLabel];
    [self.qh_downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_centerY);
        make.left.and.bottom.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
        make.right.mas_lessThanOrEqualTo(self.contentView).inset(kCellSingleMargin);
    }];
    
    // 分割线
    [self addSubview:self.qh_line];
    [self.qh_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self).with.inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.75f);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

#pragma mark - Setter

#pragma mark - Getter
- (UILabel *)qh_upLabel {
    
    if (!_qh_upLabel) {
        
        _qh_upLabel = [[UILabel alloc] init];
    }
    
    return _qh_upLabel;
}

- (UILabel *)qh_downLabel {
    
    if (!_qh_downLabel) {
        
        _qh_downLabel = [[UILabel alloc] init];
    }
    
    return _qh_downLabel;
}

- (UIView *)qh_line {
    
    if (!_qh_line) {
        
        _qh_line = [[UIView alloc] init];
        _qh_line.backgroundColor = UIColor.qh_lightStrokeColor;
    }
    
    return _qh_line;
}

@end


#pragma mark -

@interface GQHCommonInputTextDoubleHorizontalCell ()

@end

@implementation GQHCommonInputTextDoubleHorizontalCell

#pragma mark - Lifecycle
/**
 初始化列表行视图
 
 @param style 行视图样式
 @param reuseIdentifier 重用标识
 @return 自定义行视图
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
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
 自动布局子视图 -> 约束(mas_make只有一次,自动约束，不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
    // 左文本框
    [self.contentView addSubview:self.qh_leftLabel];
    [self.qh_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
        make.top.and.bottom.mas_equalTo(self.contentView);
        make.width.mas_greaterThanOrEqualTo(0.0f);
    }];
    
    // 右单行输入框
    [self.contentView addSubview:self.qh_rightTextField];
    [self.qh_rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.qh_leftLabel.mas_right);
        make.right.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
    }];
    
    // 分割线
    [self addSubview:self.qh_line];
    [self.qh_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self).with.inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.75f);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

#pragma mark - Setter

#pragma mark - Getter
- (UILabel *)qh_leftLabel {
    
    if (!_qh_leftLabel) {
        
        _qh_leftLabel = [[UILabel alloc] init];
    }
    
    return _qh_leftLabel;
}

- (UITextField *)qh_rightTextField {
    
    if (!_qh_rightTextField) {
        
        _qh_rightTextField = [[UITextField alloc] init];
    }
    
    return _qh_rightTextField;
}

- (UIView *)qh_line {
    
    if (!_qh_line) {
        
        _qh_line = [[UIView alloc] init];
        _qh_line.backgroundColor = UIColor.qh_lightStrokeColor;
    }
    
    return _qh_line;
}

@end


#pragma mark -

@interface GQHCommonInputTextDoubleVerticalCell ()

@end

@implementation GQHCommonInputTextDoubleVerticalCell

#pragma mark - Lifecycle
/**
 初始化列表行视图
 
 @param style 行视图样式
 @param reuseIdentifier 重用标识
 @return 自定义行视图
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
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
 自动布局子视图 -> 约束(mas_make只有一次,自动约束，不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
    // 标题文本框
    [self.contentView addSubview:self.qh_titleLabel];
    [self.qh_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
        make.width.and.height.mas_greaterThanOrEqualTo(0.0f);
    }];
    
    // 多行输入框
    [self.contentView addSubview:self.qh_contentTextView];
    [self.qh_contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.qh_titleLabel.mas_bottom).with.inset(kCellSingleMargin);
        make.left.and.right.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self.contentView).with.inset(kCellSingleMargin);
    }];
    
    // 分割线
    [self addSubview:self.qh_line];
    [self.qh_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self).with.inset(kCellSingleMargin);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.75f);
    }];
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

#pragma mark - Setter

#pragma mark - Getter
- (UILabel *)qh_titleLabel {
    
    if (!_qh_titleLabel) {
        
        _qh_titleLabel = [[UILabel alloc] init];
    }
    
    return _qh_titleLabel;
}

- (UITextView *)qh_contentTextView {
    
    if (!_qh_contentTextView) {
        
        _qh_contentTextView = [[UITextView alloc] init];
    }
    
    return _qh_contentTextView;
}

- (UIView *)qh_line {
    
    if (!_qh_line) {
        
        _qh_line = [[UIView alloc] init];
        _qh_line.backgroundColor = UIColor.qh_lightStrokeColor;
    }
    
    return _qh_line;
}

@end
