//
//  GQHSlideView.m
//  Seed
//
//  Created by GuanQinghao on 13/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHSlideView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface GQHSlideView () <UIScrollViewDelegate, UIGestureRecognizerDelegate>

/// 容器视图
@property (nonatomic, strong) UIScrollView *containerView;
/// 分页控件
@property (nonatomic, strong) UIPageControl *pageControl;

/// 左文本框
@property (nonatomic, strong) UILabel *leftTextLabel;
/// 左图片框
@property (nonatomic, strong) UIImageView *leftImageView;

/// 中文本框
@property (nonatomic, strong) UILabel *middleTextLabel;
/// 中图片框
@property (nonatomic, strong) UIImageView *middleImageView;

/// 右文本框
@property (nonatomic, strong) UILabel *rightTextLabel;
/// 右图片框
@property (nonatomic, strong) UIImageView *rightImageView;

/// 图片资源路径数组
@property (nonatomic, strong) NSArray *imagePathArray;

/// 自动轮播时间间隔
@property (nonatomic, assign) CGFloat duration;
/// 当前索引值
@property (nonatomic, assign) NSInteger currentIndex;
/// 定时器
@property (nonatomic, strong) NSTimer *timer;

@end


@implementation GQHSlideView
// 初始化
- (instancetype)initWithFrame:(CGRect)frame duration:(NSTimeInterval)duration {
    
    if (self = [super initWithFrame:frame]) {
        
        // 默认值
        [self setupDefault];
        
        // 定时器
        self.duration = duration;
        if (duration > 0.0f) {
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(timerDidFired:) userInfo:nil repeats:YES];
            [self.timer setFireDate:[NSDate distantFuture]];
        }
        
        // 加载视图
        [self loadUserInterface];
        // 添加观察者
        [self addObserver];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        // 默认值
        [self setupDefault];
        
        // 定时器
        self.duration = 0.0f;
        
        // 加载视图
        [self loadUserInterface];
        // 添加观察者
        [self addObserver];
    }
    
    return self;
}

// 设置默认值
- (void)setupDefault {
    
    // 轮播图属性
    _qh_onlyText = NO;
    _qh_showPageControl = YES;
    _qh_hidesForSinglePage = YES;
    _qh_slideViewContentMode = UIViewContentModeScaleAspectFit;
    _qh_scrollDirection = UICollectionViewScrollDirectionHorizontal;
    /// 分页控件属性
    _qh_pageDotColor = UIColor.lightGrayColor;
    _qh_currentPageDotColor = UIColor.whiteColor;
    // 文本框默认属性
    _qh_textLabelHeight = 0.0f;
    _qh_textLabelTextFont = [UIFont systemFontOfSize:16.0f];
    _qh_textLabelTextColor = UIColor.whiteColor;
    _qh_textLabelBackgroundColor = UIColor.lightGrayColor;
    _qh_textLabelTextAlignment = NSTextAlignmentLeft;
}

- (void)dealloc {
    
    // 移除观察者
    [self removeObserver];
    
    if (self.timer) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark --View
- (void)loadUserInterface {
    
    // 添加文本框
    [self.leftImageView addSubview:self.leftTextLabel];
    [self.middleImageView addSubview:self.middleTextLabel];
    [self.rightImageView addSubview:self.rightTextLabel];
    
    // 添加图片框
    [self.containerView addSubview:self.leftImageView];
    [self.containerView addSubview:self.middleImageView];
    [self.containerView addSubview:self.rightImageView];
    
    // 添加容器视图和分页控件
    [self addSubview:self.containerView];
    [self addSubview:self.pageControl];
    
    // 容器frame
    self.containerView.frame = self.bounds;
    // 设置contentOffset偏移量和contentSize大小
    [self setScrollViewContentOffset];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    // 图片框frame
    switch (self.qh_scrollDirection) {
            
        case UICollectionViewScrollDirectionHorizontal: {
            // 水平滚动
            self.leftImageView.frame = CGRectMake(0.0f, 0.0f, width, height);
            self.middleImageView.frame = CGRectMake(width, 0.0f, width, height);
            self.rightImageView.frame = CGRectMake(2 * width, 0.0f, width, height);
        }
            break;
        case UICollectionViewScrollDirectionVertical: {
            // 垂向滚动
            self.leftImageView.frame = CGRectMake(0.0f, 0.0f, width, height);
            self.middleImageView.frame = CGRectMake(0.0f, height, width, height);
            self.rightImageView.frame = CGRectMake(0.0f, 2 * height, width, height);
        }
            break;
    }
    
    // 文本框属性
    self.leftTextLabel.frame = self.middleTextLabel.frame = self.rightTextLabel.frame = CGRectMake(0.0f, height - _qh_textLabelHeight, width, _qh_textLabelHeight);
    self.leftTextLabel.font = self.middleTextLabel.font = self.rightTextLabel.font = _qh_textLabelTextFont;
    self.leftTextLabel.textColor = self.middleTextLabel.textColor = self.rightTextLabel.textColor = _qh_textLabelTextColor;
    self.leftTextLabel.textAlignment = self.middleTextLabel.textAlignment = self.rightTextLabel.textAlignment = _qh_textLabelTextAlignment;
    self.leftTextLabel.backgroundColor = self.middleTextLabel.backgroundColor = self.rightTextLabel.backgroundColor = _qh_textLabelBackgroundColor;
    
    // 分页控件frame
    self.pageControl.frame = CGRectMake(0.0f, height - 30.0f, width, 30.0f);
}

#pragma mark --KVO
- (void)addObserver {
    
    [self.containerView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserver {
    
    [self.containerView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        [self caculateCurrentIndex];
    }
}

#pragma mark --Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.imagePathArray && self.imagePathArray.count > 1) {
        
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.imagePathArray && self.imagePathArray.count > 1) {
        
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.duration]];
    }
}

#pragma mark --TargetMethod
- (IBAction)clickedSlideView:(UITapGestureRecognizer *)sender {
    
    if (self.qh_delegate && [self.qh_delegate respondsToSelector:@selector(qh_slideView:didSelectItemAtIndex:)]) {
        
        [self.qh_delegate qh_slideView:self didSelectItemAtIndex:self.currentIndex];
    }
}

- (IBAction)timerDidFired:(id)sender {
    
    if (self.qh_delegate && [self.qh_delegate respondsToSelector:@selector(qh_slideView:didScrollToIndex:)]) {
        
        [self.qh_delegate qh_slideView:self didScrollToIndex:self.currentIndex];
    }
    
    CGFloat criticalValue = 0.2f;
    
    switch (self.qh_scrollDirection) {
            
        case UICollectionViewScrollDirectionHorizontal: {
            // 水平滚动
            if (self.containerView.contentOffset.x < CGRectGetWidth(self.containerView.bounds) - criticalValue || self.containerView.contentOffset.x > CGRectGetWidth(self.containerView.bounds) + criticalValue) {
                
                // 设置contentOffset偏移量
                [self setScrollViewContentOffset];
            }
            
            CGPoint offset = CGPointMake(self.containerView.contentOffset.x + CGRectGetWidth(self.containerView.bounds), self.containerView.contentOffset.y);
            [self.containerView setContentOffset:offset animated:YES];
        }
            break;
            
        case UICollectionViewScrollDirectionVertical: {
            // 垂向滚动
            if (self.containerView.contentOffset.y < CGRectGetHeight(self.bounds) - criticalValue || self.containerView.contentOffset.y > CGRectGetWidth(self.bounds) + criticalValue) {
                
                // 设置contentOffset偏移量
                [self setScrollViewContentOffset];
            }
            
            CGPoint offset = CGPointMake(self.containerView.contentOffset.x, self.containerView.contentOffset.y + CGRectGetHeight(self.bounds));
            [self.containerView setContentOffset:offset animated:YES];
        }
            break;
    }
}

#pragma mark --PrivateMethod
// 计算当前索引值
- (void)caculateCurrentIndex {
    
    if (self.imagePathArray && self.imagePathArray.count > 0) {
        
        CGFloat pointX = self.containerView.contentOffset.x;
        CGFloat pointY = self.containerView.contentOffset.y;
        CGFloat criticalValue = 0.2f;
        
        switch (self.qh_scrollDirection) {
                
            case UICollectionViewScrollDirectionHorizontal: {
                // 水平滚动
                if (pointX > (2 * CGRectGetWidth(self.bounds) - criticalValue)) {
                    
                    self.currentIndex = (self.currentIndex + 1) % self.imagePathArray.count;
                } else if (pointX < criticalValue) {
                    
                    self.currentIndex = (self.currentIndex + self.imagePathArray.count - 1) % self.imagePathArray.count;
                }
            }
                break;
                
            case UICollectionViewScrollDirectionVertical: {
                // 垂向滚动
                if (pointY > (2 * CGRectGetHeight(self.bounds) - criticalValue)) {
                    
                    self.currentIndex = (self.currentIndex + 1) % self.imagePathArray.count;
                } else if (pointY < criticalValue) {
                    
                    self.currentIndex = (self.currentIndex + self.imagePathArray.count - 1) % self.imagePathArray.count;
                }
            }
                break;
        }
    }
}

// 设置偏移量
- (void)setScrollViewContentOffset {
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    switch (self.qh_scrollDirection) {
            
        case UICollectionViewScrollDirectionVertical: {
            
            self.containerView.contentSize = CGSizeMake(width, 3 * height);
            self.containerView.contentOffset = CGPointMake(0.0f, CGRectGetHeight(self.bounds));
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            
            self.containerView.contentSize = CGSizeMake(3 * width, height);
            self.containerView.contentOffset = CGPointMake(CGRectGetWidth(self.bounds), 0.0f);
        }
            break;
    }
}

#pragma mark --Setter
- (void)setQh_imageArray:(NSArray *)qh_imageArray {
    
    // image or imageName or imagePath
    _qh_imageArray = qh_imageArray;
    self.imagePathArray = [qh_imageArray copy];
}

- (void)setQh_imageURLArray:(NSArray *)qh_imageURLArray {
    
    // imageURL or imageURLString
    _qh_imageURLArray = qh_imageURLArray;
    
    NSMutableArray *temp = [NSMutableArray array];
    [_qh_imageURLArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *URLString;
        if ([obj isKindOfClass:[NSString class]]) {
            
            URLString = obj;
        } else if ([obj isKindOfClass:[NSURL class]]){
            
            URLString = [obj absoluteString];
        } else {
            
            NSLog(@"obj exception! -- %s -- %d", __FUNCTION__, __LINE__);
        }
        
        if (URLString) {
            
            [temp addObject:URLString];
        }
    }];
    
    self.imagePathArray = [temp copy];
}

- (void)setImagePathArray:(NSArray *)imagePathArray {
    
    if (imagePathArray) {
        
        _imagePathArray = imagePathArray;
        self.currentIndex = 0;
        
        if (imagePathArray.count > 1) {
            
            [self.timer setFireDate: [NSDate dateWithTimeIntervalSinceNow:self.duration]];
            self.pageControl.numberOfPages = imagePathArray.count;
            self.pageControl.currentPage = 0;
            self.pageControl.hidden = NO;
        } else {
            
            self.pageControl.hidden = YES;
            [self.leftImageView removeFromSuperview];
            [self.rightImageView removeFromSuperview];
            self.containerView.contentSize = CGSizeMake(CGRectGetWidth(self.containerView.bounds), 0.0f);
        }
    }
}

- (void)setQh_textArray:(NSArray *)qh_textArray {
    
    _qh_textArray = qh_textArray;
    
    // 首次加载显示文本内容
    self.middleTextLabel.text = qh_textArray[self.currentIndex];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    if (_currentIndex >= 0) {
        
        _currentIndex = currentIndex;
        
        NSInteger imageCount = self.imagePathArray.count;
        NSInteger leftIndex = (currentIndex + imageCount - 1) % imageCount;
        NSInteger rightIndex = (currentIndex + 1) % imageCount;
        
        // 左图片框
        NSString *leftImagePath = self.imagePathArray[leftIndex];
        
        if (!self.qh_onlyText && [leftImagePath isKindOfClass:[NSString class]]) {
            
            if ([leftImagePath hasPrefix:@"http"]) {
                
                [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftImagePath]];
            } else {
                
                UIImage *image = [UIImage imageNamed:leftImagePath];
                if (!image) {
                    
                    image = [UIImage imageWithContentsOfFile:leftImagePath];
                }
                self.leftImageView.image = image;
            }
        } else if (!self.qh_onlyText && [leftImagePath isKindOfClass:[UIImage class]]) {
            
            self.leftImageView.image = (UIImage *)leftImagePath;
        } else {
            
            NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        }
        
        // 中图片框
        NSString *middleImagePath = self.imagePathArray[currentIndex];
        
        if (!self.qh_onlyText && [middleImagePath isKindOfClass:[NSString class]]) {
            
            if ([middleImagePath hasPrefix:@"http"]) {
                
                [self.middleImageView sd_setImageWithURL:[NSURL URLWithString:middleImagePath]];
            } else {
                
                UIImage *image = [UIImage imageNamed:middleImagePath];
                if (!image) {
                    
                    image = [UIImage imageWithContentsOfFile:middleImagePath];
                }
                self.middleImageView.image = image;
            }
        } else if (!self.qh_onlyText && [middleImagePath isKindOfClass:[UIImage class]]) {
            
            self.middleImageView.image = (UIImage *)middleImagePath;
        } else {
            
            NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        }
        
        // 右图片框
        NSString *rightImagePath = self.imagePathArray[rightIndex];
        
        if (!self.qh_onlyText && [rightImagePath isKindOfClass:[NSString class]]) {
            
            if ([rightImagePath hasPrefix:@"http"]) {
                
                [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightImagePath]];
            } else {
                
                UIImage *image = [UIImage imageNamed:rightImagePath];
                if (!image) {
                    
                    image = [UIImage imageWithContentsOfFile:rightImagePath];
                }
                self.rightImageView.image = image;
            }
        } else if (!self.qh_onlyText && [rightImagePath isKindOfClass:[UIImage class]]) {
            
            self.rightImageView.image = (UIImage *)rightImagePath;
        } else {
            
            NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        }
        
        if (self.qh_textArray) {
            
            self.leftTextLabel.text = self.qh_textArray[leftIndex];
            self.middleTextLabel.text = self.qh_textArray[currentIndex];
            self.rightTextLabel.text = self.qh_textArray[rightIndex];
        }
        
        // 设置contentOffset偏移量
        [self setScrollViewContentOffset];
        self.pageControl.currentPage = currentIndex;
    }
}

#pragma mark 轮播属性
- (void)setQh_showPageControl:(BOOL)qh_showPageControl {
    
    if (qh_showPageControl) {
        
        self.pageControl.hidden = NO;
    } else {
        
        self.pageControl.hidden = YES;
    }
}

- (void)setQh_hidesForSinglePage:(BOOL)qh_hidesForSinglePage {
    
    if (self.imagePathArray && 1 == self.imagePathArray.count && qh_hidesForSinglePage) {
        
        self.pageControl.hidden = YES;
    } else {
        
        self.pageControl.hidden = NO;
    }
}

- (void)setQh_slideViewContentMode:(UIViewContentMode)qh_slideViewContentMode {
    
    self.leftImageView.contentMode = self.middleImageView.contentMode = self.rightImageView.contentMode = qh_slideViewContentMode;
}

#pragma mark 分页控件属性
- (void)setQh_pageDotColor:(UIColor *)qh_pageDotColor {
    
    _qh_pageDotColor = qh_pageDotColor;
    self.pageControl.pageIndicatorTintColor = qh_pageDotColor;
}

- (void)setQh_currentPageDotColor:(UIColor *)qh_currentPageDotColor {
    
    _qh_currentPageDotColor = qh_currentPageDotColor;
    self.pageControl.currentPageIndicatorTintColor = qh_currentPageDotColor;
}

#pragma mark --Getter
- (UIScrollView *)containerView {
    
    if (!_containerView) {
        
        _containerView = [[UIScrollView alloc] init];
        _containerView.delegate = self;
        _containerView.pagingEnabled = YES;
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.directionalLockEnabled = YES;
    }
    
    return _containerView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = _qh_pageDotColor;
        _pageControl.currentPageIndicatorTintColor = _qh_currentPageDotColor;
    }
    
    return _pageControl;
}

- (UILabel *)leftTextLabel {
    
    if (!_leftTextLabel) {
        
        _leftTextLabel = [[UILabel alloc] init];
    }
    
    return _leftTextLabel;
}

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = _qh_slideViewContentMode;
        _leftImageView.layer.masksToBounds= YES;
    }
    
    return _leftImageView;
}

- (UILabel *)middleTextLabel {
    
    if (!_middleTextLabel) {
        
        _middleTextLabel = [[UILabel alloc] init];
    }
    
    return _middleTextLabel;
}

- (UIImageView *)middleImageView {
    
    if (!_middleImageView) {
        
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.contentMode = _qh_slideViewContentMode;
        _middleImageView.layer.masksToBounds= YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedSlideView:)];
        [_middleImageView addGestureRecognizer:tap];
        _middleImageView.userInteractionEnabled = YES;
    }
    
    return _middleImageView;
}

- (UILabel *)rightTextLabel {
    
    if (!_rightTextLabel) {
        
        _rightTextLabel = [[UILabel alloc] init];
    }
    
    return _rightTextLabel;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.contentMode = _qh_slideViewContentMode;
        _rightImageView.layer.masksToBounds= YES;
    }
    
    return _rightImageView;
}

@end
