//
//  GQHGameView.m
//  Seed
//
//  Created by GuanQinghao on 04/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHGameView.h"
#import "GQHHeader.h"


/// 局部常量-间距
static CGFloat const kSpacing = 10.0f;
/// 局部常量-预览视图宽度
static CGFloat const kPreviewWidth = 150.0f;
/// 局部常量-预览视图高度(宽度与高度相同)
static CGFloat const kPreviewHeight = 150.0f;
/// 局部常量-板视图高度
static CGFloat const kBoardViewHeight = 0.5 * (kPreviewHeight - kSpacing);


@implementation GQHGameView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
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
    
    UIView *dashBoardView = [[UIView alloc] init];
    dashBoardView.backgroundColor = [UIColor whiteColor];
    [self addSubview:dashBoardView];
    [dashBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self).with.offset(self.qh_statusBarHeight + self.qh_navigationBarHeight + kSpacing);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(kPreviewHeight);
    }];
    
    /// 游戏图片预览
    _qh_previewImageView = [[UIImageView alloc] init];
    NSString *imageName = [NSUserDefaults.standardUserDefaults valueForKey:GQHUserImageKey];
    _qh_previewImageView.image = [UIImage imageNamed:imageName];
    _qh_previewImageView.layer.cornerRadius = 10.0f;
    _qh_previewImageView.layer.masksToBounds = YES;
    [dashBoardView addSubview:_qh_previewImageView];
    [_qh_previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(dashBoardView).with.offset(kSpacing);
        make.centerY.mas_equalTo(dashBoardView);
        make.size.mas_equalTo(CGSizeMake(kPreviewWidth, kPreviewHeight));
    }];
    
    /// 纪录板
    UIView *recordBoardView = [[UIView alloc] init];
    recordBoardView.backgroundColor = [UIColor redColor];
    recordBoardView.layer.cornerRadius = 5.0f;
    recordBoardView.layer.masksToBounds = YES;
    [dashBoardView addSubview:recordBoardView];
    [recordBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(dashBoardView);
        make.left.mas_equalTo(_qh_previewImageView.mas_right).with.offset(kSpacing);
        make.right.mas_equalTo(dashBoardView).with.inset(kSpacing);
        make.height.mas_equalTo(kBoardViewHeight);
    }];
    
    UILabel *bestTimeLabel = [[UILabel alloc] init];
    bestTimeLabel.text = @"BestTime";
    bestTimeLabel.textAlignment = NSTextAlignmentCenter;
    bestTimeLabel.font = [UIFont qh_defaultFont];
    [recordBoardView addSubview:bestTimeLabel];
    [bestTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(recordBoardView);
        make.left.mas_equalTo(recordBoardView);
        make.height.mas_equalTo(0.5 * kBoardViewHeight);
        make.width.mas_equalTo(recordBoardView.mas_width).multipliedBy(0.6);
    }];
    
    _qh_bestTimeTextLabel = [[UILabel alloc]init];
    _qh_bestTimeTextLabel.text = @"99:59";
    _qh_bestTimeTextLabel.font = [UIFont qh_defaultFont];
    _qh_bestTimeTextLabel.textColor = [UIColor qh_darkBlackColor];
    _qh_bestTimeTextLabel.textAlignment = NSTextAlignmentCenter;
    [recordBoardView addSubview:_qh_bestTimeTextLabel];
    [_qh_bestTimeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(bestTimeLabel);
        make.right.mas_equalTo(recordBoardView);
        make.left.mas_equalTo(bestTimeLabel.mas_right);
        make.height.mas_equalTo(bestTimeLabel);
    }];
    
    UILabel *leastCountLabel = [[UILabel alloc] init];
    leastCountLabel.text = @"LeastCount";
    leastCountLabel.font = [UIFont qh_defaultFont];
    leastCountLabel.textAlignment = NSTextAlignmentCenter;
    [recordBoardView addSubview:leastCountLabel];
    [leastCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(bestTimeLabel.mas_bottom);
        make.left.mas_equalTo(recordBoardView);
        make.height.mas_equalTo(0.5 * kBoardViewHeight);
        make.width.mas_equalTo(recordBoardView.mas_width).multipliedBy(0.6);
    }];
    
    _qh_leastCountTextLabel = [[UILabel alloc]init];
    _qh_leastCountTextLabel.text = @"9999";
    _qh_leastCountTextLabel.font = [UIFont qh_defaultFont];
    _qh_leastCountTextLabel.textColor = [UIColor qh_darkBlackColor];
    _qh_leastCountTextLabel.textAlignment = NSTextAlignmentCenter;
    [recordBoardView addSubview:_qh_leastCountTextLabel];
    [_qh_leastCountTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(leastCountLabel);
        make.left.mas_equalTo(leastCountLabel.mas_right);
        make.right.mas_equalTo(recordBoardView);
        make.height.mas_equalTo(leastCountLabel);
    }];
    
    /// 记分板
    UIView *scoreBoardView = [[UIView alloc] init];
    scoreBoardView.backgroundColor = [UIColor greenColor];
    scoreBoardView.layer.cornerRadius = 5.0f;
    scoreBoardView.layer.masksToBounds = YES;
    [dashBoardView addSubview:scoreBoardView];
    [scoreBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(recordBoardView.mas_bottom).with.offset(kSpacing);
        make.left.mas_equalTo(_qh_previewImageView.mas_right).with.offset(kSpacing);
        make.right.mas_equalTo(dashBoardView).with.inset(kSpacing);
        make.height.mas_equalTo(kBoardViewHeight);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text= @"游戏时间";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont qh_defaultFont];
    [scoreBoardView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(scoreBoardView);
        make.left.mas_equalTo(scoreBoardView);
        make.height.mas_equalTo(0.5 * kBoardViewHeight);
        make.width.mas_equalTo(scoreBoardView.mas_width).multipliedBy(0.6);
    }];
    
    _qh_timeTextLabel = [[UILabel alloc]init];
    _qh_timeTextLabel.text = @"99:59";
    _qh_timeTextLabel.font = [UIFont qh_defaultFont];
    _qh_timeTextLabel.textColor = [UIColor qh_darkBlackColor];
    _qh_timeTextLabel.textAlignment = NSTextAlignmentCenter;
    [scoreBoardView addSubview:_qh_timeTextLabel];
    [_qh_timeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(timeLabel);
        make.left.mas_equalTo(timeLabel.mas_right);
        make.right.mas_equalTo(scoreBoardView);
        make.height.mas_equalTo(timeLabel);
    }];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.text = @"CurrentCount";
    countLabel.font = [UIFont qh_defaultFont];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [scoreBoardView addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(timeLabel.mas_bottom);
        make.left.mas_equalTo(scoreBoardView);
        make.height.mas_equalTo(0.5 * kBoardViewHeight);
        make.width.mas_equalTo(recordBoardView.mas_width).multipliedBy(0.6);
    }];
    
    _qh_countTextLabel = [[UILabel alloc]init];
    _qh_countTextLabel.text = @"98653";
    _qh_countTextLabel.font = [UIFont qh_defaultFont];
    _qh_countTextLabel.textColor = [UIColor qh_darkBlackColor];
    _qh_countTextLabel.textAlignment = NSTextAlignmentCenter;
    [scoreBoardView addSubview:_qh_countTextLabel];
    [_qh_countTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(countLabel);
        make.left.mas_equalTo(countLabel.mas_right);
        make.right.mas_equalTo(scoreBoardView);
        make.height.mas_equalTo(countLabel);
    }];
    
    /// 游戏区
    _qh_gameView = [[UIView alloc] init];
    _qh_gameView.backgroundColor = [UIColor qh_lightStrokeColor];
    _qh_gameView.layer.borderWidth = 1.0f;
    _qh_gameView.layer.borderColor = [UIColor qh_strokeColor].CGColor;
    [self addSubview:_qh_gameView];
    [_qh_gameView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(dashBoardView.mas_bottom).with.offset(2.0 * kSpacing);
        make.left.mas_equalTo(self).with.offset(kSpacing);
        make.right.mas_equalTo(self).with.inset(kSpacing);
        make.height.mas_equalTo(_qh_gameView.mas_width);
    }];
}

#pragma mark --Delegate

#pragma mark --TargetMethod

#pragma mark --PrivateMethod

#pragma mark --Setter

#pragma mark --Getter

@end
