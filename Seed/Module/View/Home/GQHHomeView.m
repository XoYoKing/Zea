//
//  GQHHomeView.m
//  Seed
//
//  Created by GuanQinghao on 08/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHHomeView.h"
#import "GQHHeader.h"


@interface GQHHomeView ()

@end


@implementation GQHHomeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadLocalData];
        [self loadUserInterface];
    }
    return self;
}

#pragma mark --Data
- (void)loadLocalData {
    
}

#pragma mark --View
- (void)loadUserInterface {
    
    [self addSubview:self.qh_tableView];
    [self.qh_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self).with.offset(self.qh_statusBarHeight + self.qh_navigationBarHeight);
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (UITableView *)qh_tableView {
    
    if (!_qh_tableView) {
        
        _qh_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _qh_tableView.backgroundColor = UIColor.whiteColor;
        _qh_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _qh_tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _qh_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _qh_tableView;
}

@end


/// 首页菜单Cell
@interface GQHHomeViewCell ()

/// 菜单容器
@property (nonatomic, strong) UIView *containerView;

@end


@implementation GQHHomeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self loadUserInterface];
    }
    return self;
}

#pragma mark --View
- (void)loadUserInterface {
    
    [self.containerView  addSubview:self.qh_titleLabel];
    [self.qh_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(self.containerView).with.inset(10.0f);
        make.height.mas_equalTo(40.0f);
    }];
    
    [self.containerView  addSubview:self.qh_subTitleLabel];
    [self.qh_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.bottom.mas_equalTo(self.containerView).with.inset(10.0f);
        make.height.mas_equalTo(30.0f);
    }];
    
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.left.and.right.mas_equalTo(self.contentView).with.inset(GQHFrameSingleMargin);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter
- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.redColor;
        
        _containerView.layer.cornerRadius = 5.0f;
        
//        [_containerView qh_cornerWithRaius:5.0f byRoundingCorners:UIRectCornerAllCorners];
        
        _containerView.layer.masksToBounds= YES;
    }
    
    return _containerView;
}

- (UILabel *)qh_titleLabel {
    
    if (!_qh_titleLabel) {
        
        _qh_titleLabel = [[UILabel alloc] init];
        _qh_titleLabel.font = [UIFont boldSystemFontOfSize:32.0f];
        _qh_titleLabel.textAlignment = NSTextAlignmentLeft;
        _qh_titleLabel.textColor = UIColor.blackColor;
    }
    
    return _qh_titleLabel;
}

- (UILabel *)qh_subTitleLabel {
    
    if (!_qh_subTitleLabel) {
        
        _qh_subTitleLabel = [[UILabel alloc] init];
        _qh_subTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        _qh_subTitleLabel.textAlignment = NSTextAlignmentLeft;
        _qh_subTitleLabel.textColor = UIColor.grayColor;
    }
    
    return _qh_subTitleLabel;
}

@end

