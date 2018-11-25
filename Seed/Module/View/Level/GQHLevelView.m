//
//  GQHLevelView.m
//  Seed
//
//  Created by GuanQinghao on 09/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHLevelView.h"
#import "GQHHeader.h"


@interface GQHLevelView ()

@end


@implementation GQHLevelView

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
        _qh_tableView.allowsMultipleSelection = NO;
        _qh_tableView.allowsSelection = YES;
        _qh_tableView.showsVerticalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            
            _qh_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _qh_tableView;
}

@end


// 难度等级Cell
@implementation GQHLevelViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self loadUserInterface];
    }
    return self;
}

#pragma mark --View
- (void)loadUserInterface {
    
    [self.contentView addSubview:self.qh_levelImageView];
    [self.qh_levelImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView).with.inset(GQHFrameSingleMargin);
        make.left.mas_equalTo(self.contentView).with.inset(GQHFrameSingleMargin);
        make.right.mas_equalTo(self.contentView).with.inset(GQHFrameSingleMargin);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if (selected) {
        
        self.qh_levelImageView.layer.borderColor = UIColor.qh_appRedColor.CGColor;
        self.qh_levelImageView.layer.borderWidth = 2.0f;
    } else {
        
        self.qh_levelImageView.layer.borderColor = UIColor.clearColor.CGColor;
        self.qh_levelImageView.layer.borderWidth = CGFLOAT_MIN;
    }
}

#pragma mark --Setter

#pragma mark --Getter
- (UIImageView *)qh_levelImageView {
    
    if (!_qh_levelImageView) {
        
        _qh_levelImageView = [[UIImageView alloc] init];
        _qh_levelImageView.backgroundColor = UIColor.whiteColor;
        _qh_levelImageView.layer.cornerRadius = 5.0f;
        _qh_levelImageView.layer.masksToBounds = YES;
        
    }
    
    return _qh_levelImageView;
}

@end
