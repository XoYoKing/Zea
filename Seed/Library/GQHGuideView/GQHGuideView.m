//
//  GQHGuideView.m
//  Seed
//
//  Created by GuanQinghao on 2018/10/22.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHGuideView.h"
#import "GQHHeader.h"


/// 版本号键值
NSString * const kAppVersion = @"AppShortVersionString";

@interface GQHGuideViewManager () <UIScrollViewDelegate>

/// 应用窗口
@property (nonatomic, strong) UIWindow *window;
/// 引导页容器视图
@property (nonatomic, strong) UIView *containerView;
/// 引导页滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
/// 跳过按钮
@property (nonatomic, strong) UIButton *skipButton;
/// 开始按钮
@property (nonatomic, strong) UIButton *startButton;
/// 分页控件
@property (nonatomic, strong) UIPageControl *pageControl;
/// 图片数组(本地图片)
@property (nonatomic, strong) NSArray *imageArray;

@end


@implementation GQHGuideViewManager
//单例
+ (instancetype)qh_sharedManager {

    static GQHGuideViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[[self class] alloc] init];
    });
    
    return manager;
}

- (void)qh_showGuideViewWithImageArray:(NSArray *)imageArray {
    
    if (imageArray && imageArray.count > 0) {
        
        self.imageArray = imageArray;
        [self loadUserInterface];
    }
}

#pragma mark --View
- (void)loadUserInterface {
    
    CGFloat width = CGRectGetWidth(self.window.bounds);
    CGFloat height = CGRectGetHeight(self.window.bounds);
    
    self.containerView.frame = self.window.bounds;
    [self.window addSubview:self.containerView];
    
    self.scrollView.frame = self.window.bounds;
    self.scrollView.contentSize = CGSizeMake(width * self.imageArray.count, height);
    [self.containerView addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < self.imageArray.count; i++) {
        
        // 引导图片框
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * width, 0.0f, width, height);
        imageView.image = [UIImage imageNamed:self.imageArray[i]];
        [self.scrollView addSubview:imageView];
        
        if (i == self.imageArray.count - 1) {
            
            imageView.userInteractionEnabled = YES;
            
            self.startButton.frame = CGRectMake(0.3 * width, 0.8 * height, 0.4 * width, 40.0f);
            [imageView addSubview:self.startButton];
        }
    }
    
    // 跳过按钮
    self.skipButton.frame = CGRectMake(0.8 * width, 0.2 * width, 60.0f, 30.0f);
    [self.containerView addSubview:self.skipButton];
    
    // 分页控件
    self.pageControl.frame = CGRectMake(0.0f, 0.9 * height, width, 0.1 * height);
    self.pageControl.numberOfPages = self.imageArray.count;
    self.pageControl.currentPage = 0;
    [self.containerView addSubview:self.pageControl];
}

#pragma mark --Delegate
// 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = CGRectGetWidth(scrollView.frame);
    
    
    
    NSInteger page = round(offsetX / width);
    
    NSLog(@"%ld",page);
    
    self.pageControl.currentPage = page;
    
    if (self.imageArray && page == self.imageArray.count - 1 && self.qh_autoIn) {
        
        [self removeGuideView:nil];
    }
}

#pragma mark --TargetMethod
// 移除引导视图
- (IBAction)removeGuideView:(UIButton *)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.3f animations:^{
            
            [self.containerView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            
            [self.containerView removeFromSuperview];
        }];
    });
}

#pragma mark --PrivateMethod

#pragma mark --Setter
- (void)setQh_debut:(BOOL)qh_debut {
    
    NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *appVersion = [NSUserDefaults.standardUserDefaults objectForKey:kAppVersion];
    
    if (qh_debut && [currentVersion isEqualToString:appVersion]) {
        
        [self.containerView removeFromSuperview];
    }
    [NSUserDefaults.standardUserDefaults setObject:currentVersion forKey:kAppVersion];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)setQh_hideIndicator:(BOOL)qh_hideIndicator {
    
    self.pageControl.hidden = qh_hideIndicator;
}


#pragma mark --Getter
- (UIWindow *)window {
    
    if (!_window) {
        
        _window = [UIApplication sharedApplication].keyWindow;
    }
    
    return _window;
}

- (UIView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = UIColor.lightGrayColor;
    }
    
    return _containerView;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = UIColor.lightGrayColor;
    }
    
    return _scrollView;
}

- (UIButton *)skipButton {
    
    if (!_skipButton) {
        
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.backgroundColor = UIColor.grayColor;
        _skipButton.layer.cornerRadius = 5.0f;
        _skipButton.layer.masksToBounds = YES;
        [_skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipButton addTarget:self action:@selector(removeGuideView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _skipButton;
}

- (UIButton *)startButton {
    
    if (!_startButton) {
        
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startButton.backgroundColor = UIColor.grayColor;
        _startButton.layer.cornerRadius = 5.0f;
        _startButton.layer.masksToBounds = YES;
        _startButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        [_startButton setTitle:@"开始体验" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(removeGuideView:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _startButton;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = UIColor.grayColor;
        _pageControl.currentPageIndicatorTintColor = UIColor.whiteColor;
    }
    
    return _pageControl;
}

- (NSArray<UIImage *> *)imageArray {
    
    if (!_imageArray) {
        
        _imageArray = [NSArray array];
    }
    
    return _imageArray;
}

@end

