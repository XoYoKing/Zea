//
//  GQHHomeController.m
//  Seed
//
//  Created by GuanQinghao on 07/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#pragma mark Macro
#import "GQHHeader.h"

#pragma mark Model

#pragma mark Object

#pragma mark View
#import "GQHHomeView.h"
#import "GQHLockView.h"


#pragma mark Controller
#import "GQHHomeController.h"

#pragma mark CocoaPods

#pragma mark ----------Header End----------

@interface GQHHomeController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,GQHLockViewDelegate>

/// 自定义根视图
@property (nonatomic, strong) GQHHomeView *rootView;
/// 定时器
@property (nonatomic, strong) dispatch_source_t timer;

@end


@implementation GQHHomeController

#pragma mark --Lifecycle
- (void)loadView {
    // 添加自定义视图
    DLog();
    
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DLog();
    
//    self.timer;
    
    GQHLockView *lockView = [[GQHLockView alloc] initWithFrame:CGRectMake(0, 210, 414, 414)];
    lockView.qh_delegate = self;
    [self.rootView addSubview:lockView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog();
    
    self.qh_backButton.hidden = YES;
    [self.qh_titleButton setTitle:@"首页" forState:UIControlStateNormal];
    self.qh_rightMostButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    DLog();
    
}

#pragma mark --Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(100.0f, 120.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GQHHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass([GQHHomeCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.qh_titleLabel.text = [NSString stringWithFormat:@"第%ld个按钮", indexPath.row];
    cell.qh_imageView.image = [UIImage qh_imageWithColor:UIColor.qh_colorWithRandomRGB size:CGSizeMake(70.0f, 70.0f)];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [GQHLogger qh_print: NSStringFromSelector(_cmd)];
    
}

- (void)qh_lockView:(GQHLockView *)lockView value:(NSString *)value {
    
    DLog(@"%@",value);
    
    if ([value isEqualToString:@"13457"]) {
        
        lockView.qh_show = NO;
        DLog(@"密码正确");
    } else {
        
        lockView.qh_show = YES;
        DLog(@"密码错误");
    }
}

#pragma mark --TargetMethod
- (IBAction)qh_oneActino:(UIButton *)sender {
    
    [UIView qh_animateScaledWithLayer:sender.layer type:GQHAnimationScaledTypeInOut];
    
}

- (IBAction)qh_twoActino:(UIButton *)sender {
    
    [UIView qh_animateShakedWithLayer:sender.layer type:GQHAnimationShakedTypeHorizontal];
    
}

#pragma mark --PrivateMethod
- (void)logger {
    
    [GQHLogger qh_print: NSStringFromSelector(_cmd)];
}

#pragma mark --Setter

#pragma mark --Getter
- (GQHHomeView *)rootView {
    
    if (!_rootView) {
        
        _rootView = [[GQHHomeView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _rootView.qh_collectionView.delegate = self;
        _rootView.qh_collectionView.dataSource = self;
    }
    
    return _rootView;
}

- (dispatch_source_t)timer {
    
    if (!_timer) {
        
        // 创建队列
        dispatch_queue_t queue = dispatch_get_main_queue();
        // 创建GCD中的定时器
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        // 设置时间等
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0f * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        // 调用的任务
        dispatch_source_set_event_handler(_timer, ^{
            
            [self logger];
        });
        // 开始执行
        dispatch_resume(_timer);
    }
    
    return _timer;
}

@end
