//
//  GQHCommonCell.m
//  Seed
//
//  Created by GuanQinghao on 03/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHCommonCell.h"
#import "GQHHeader.h"


CGFloat const GQHCommonCellSingleMargin = 8.0f;
CGFloat const GQHCommonCellDoubleMargin = 2 * GQHCommonCellSingleMargin;


/// 纯文本 单行单列 TextSingle
@implementation GQHCommonTextSingleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadUserInterface];
    }
    return self;
}

- (void)loadUserInterface {
    
    _qh_textLabel = [[UILabel alloc] init];
    _qh_textLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_qh_textLabel];
    [_qh_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.mas_equalTo(self.contentView).with.inset(GQHCommonCellSingleMargin);
        make.top.and.bottom.mas_equalTo(self.contentView);
    }];
    
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = UIColor.qh_lightStrokeColor;
    [self.contentView addSubview:separatorView];
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).with.offset(GQHCommonCellSingleMargin);
        make.right.mas_equalTo(self.contentView).with.inset(GQHCommonCellSingleMargin);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
}

@end


/// 纯文本 水平双文本 TextDoubleHorizontal
@implementation GQHCommonTextDoubleHorizontalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadUserInterface];
    }
    return self;
}

- (void)loadUserInterface {
    
    _qh_leftLabel = [[UILabel alloc] init];
    _qh_leftLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_qh_leftLabel];
    [_qh_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).with.inset(GQHCommonCellSingleMargin);
        make.right.mas_equalTo(self.contentView.mas_centerX);
        make.top.and.bottom.mas_equalTo(self.contentView);
    }];
    
    _qh_rightLabel = [[UILabel alloc] init];
    _qh_rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_qh_rightLabel];
    [_qh_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView.mas_centerX);
        make.right.mas_equalTo(self.contentView).with.inset(GQHCommonCellSingleMargin);
    }];
    
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = UIColor.qh_lightStrokeColor;
    [self.contentView addSubview:separatorView];
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self).with.offset(GQHCommonCellSingleMargin);
        make.right.mas_equalTo(self).with.inset(GQHCommonCellSingleMargin);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
}

@end


/// 纯文本 垂直双文本 TextDoubleVertical
@implementation GQHCommonTextDoubleVerticalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadUserInterface];
    }
    return self;
}

- (void)loadUserInterface {
    
    _qh_upLabel = [[UILabel alloc] init];
    _qh_upLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_qh_upLabel];
    [_qh_upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(self.contentView).inset(GQHCommonCellSingleMargin);
        make.bottom.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    _qh_downLabel = [[UILabel alloc] init];
    _qh_downLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_qh_downLabel];
    [_qh_downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_centerY);
        make.left.and.bottom.and.right.mas_equalTo(self.contentView).with.inset(GQHCommonCellSingleMargin);
    }];
    
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = UIColor.qh_lightStrokeColor;
    [self.contentView addSubview:separatorView];
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView).with.offset(GQHCommonCellSingleMargin);
        make.right.mas_equalTo(self.contentView).with.inset(GQHCommonCellSingleMargin);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
}

@end
