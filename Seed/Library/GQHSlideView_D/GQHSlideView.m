//
//  GQHSlideView.m
//  Seed
//
//  Created by GuanQinghao on 13/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHSlideView.h"
#import "GQHCollectionViewCell.h"
#import "GQHPageControl.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>

#define kGQHSlideVeiwDefaultPageControlDotSize CGSizeMake(10, 10)

static NSString *identifier = @"GQHCollectionViewCell";

@interface GQHSlideView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *slideCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) UIControl *pageControl;
@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, strong) NSArray *imagePathArray;

@end

@implementation GQHSlideView

+ (instancetype)qh_slideViewWithFrame:(CGRect)frame delegate:(id<GQHSlideViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage {
    
    GQHSlideView *slideView = [[self alloc] initWithFrame:frame];
    slideView.qh_delegate = delegate;
    slideView.qh_placeholderImage = placeholderImage;
    
    return slideView;
}

+ (instancetype)qh_slideViewWithFrame:(CGRect)frame imageURLArray:(NSArray *)imageURLArray {
    
    GQHSlideView *slideView = [[self alloc] initWithFrame:frame];
    slideView.qh_imageURLArray = [NSMutableArray arrayWithArray:imageURLArray];
    
    return slideView;
}

+ (instancetype)qh_slideViewWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    
    GQHSlideView *slideView = [[self alloc] initWithFrame:frame];
    slideView.qh_imageArray = [NSMutableArray arrayWithArray:imageArray];
    
    return slideView;
}

+ (instancetype)qh_slideViewWithFrame:(CGRect)frame loop:(BOOL)endless imageArray:(NSArray *)imageArray {
    
    GQHSlideView *slideView = [[self alloc] initWithFrame:frame];
    slideView.qh_endless = endless;
    slideView.qh_imageArray = [NSMutableArray arrayWithArray:imageArray];
    
    return slideView;
}

+ (void)qh_clearImageCache {
    
    [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:nil];
}

- (void)qh_slideView:(GQHSlideView *)slideView scrollToIndex:(NSInteger)index {
    
    if (self.qh_autoScroll) {
        
        [self invalidateTimer];
    }
    
    if (0 == _itemCount) {
        
        return;
    }
    
    [self scrollToIndex:(NSInteger)(_itemCount * 0.5 + index)];
    
    if (self.qh_autoScroll) {
        
        [self setupTimer];
    }
}

- (void)qh_adjustWhenViewWillAppear {
    
    long index = [self currentIndex];
    if (index < _itemCount) {
        
        [_slideCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

- (void)qh_disableScrollGesture {
    
    self.slideCollectionView.canCancelContentTouches = NO;
    for (UIGestureRecognizer *gesture in self.slideCollectionView.gestureRecognizers) {
        
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
            
            [self.slideCollectionView removeGestureRecognizer:gesture];
        }
    }
}

#pragma mark --initialization
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initialization];
        [self setupSlideCollectionView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialization];
    [self setupSlideCollectionView];
}

- (void)initialization {
    
    // 轮播属性
    _qh_timeInterval = 3.0;
    _qh_endless = YES;
    _qh_autoScroll = YES;
    
    // 自定义样式
    _qh_slideViewContentMode = UIViewContentModeScaleToFill;
    _qh_showPageControl = YES;
    _qh_hidesForSinglePage = YES;
    
    _qh_pageControlStyle = GQHPageControlStyleClassic;
    _qh_pageControlAlignment = GQHPageControlAlignmentCenter;
    
    _qh_pageControlOffsetLeft = 0;
    _qh_pageControlOffsetRight = 0;
    _qh_pageControlOffsetBottom = 0;
    _qh_pageControlDotSize = kGQHSlideVeiwDefaultPageControlDotSize;
    
    _qh_pageDotColor = [UIColor lightGrayColor];
    _qh_currentPageDotColor = [UIColor whiteColor];
    
    _qh_titleLabelTextColor = [UIColor whiteColor];
    _qh_titleLabelTextFont = [UIFont systemFontOfSize:16.0];
    _qh_titleLabelBackgroundColor = [UIColor grayColor];
    _qh_titleLabelHeight = 30.0;
    _qh_titleLabelTextAlignment = NSTextAlignmentLeft;
    
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)setupSlideCollectionView {
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _slideCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _slideCollectionView.delegate = self;
    _slideCollectionView.dataSource = self;
    _slideCollectionView.scrollsToTop = NO;
    _slideCollectionView.pagingEnabled = YES;
    _slideCollectionView.showsVerticalScrollIndicator = NO;
    _slideCollectionView.showsHorizontalScrollIndicator = NO;
    _slideCollectionView.backgroundColor = [UIColor clearColor];
    [_slideCollectionView registerClass:[GQHCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:_slideCollectionView];
}

#pragma mark --Lifecycle
- (void)layoutSubviews {
    
    self.qh_delegate = self.qh_delegate;
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    _slideCollectionView.frame = self.bounds;
    
    if (_slideCollectionView.contentOffset.x == 0 && _itemCount) {
        
        int targetIndex = 0;
        if (self.qh_endless) {
            
            targetIndex = _itemCount * 0.1;
        } else {
            
            targetIndex = 0;
        }
        [_slideCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
    if ([self.pageControl isKindOfClass:[GQHPageControl class]]) {
        
        GQHPageControl *pageControl = (GQHPageControl *)_pageControl;
        if (!(self.qh_pageDotImage && self.qh_currentPageDotImage && CGSizeEqualToSize(kGQHSlideVeiwDefaultPageControlDotSize, self.qh_pageControlDotSize))) {
            
            pageControl.qh_dotSize = self.qh_pageControlDotSize;
        }
        
        size = [pageControl qh_sizeForNumberOfPages:self.imagePathArray.count];
    } else {
        
        size = CGSizeMake(self.imagePathArray.count * self.qh_pageControlDotSize.width * 1.5, self.qh_pageControlDotSize.height);
    }
    
    CGFloat x = (CGRectGetWidth(self.frame) - size.width) * 0.5;
    if (self.qh_pageControlAlignment == GQHPageControlAlignmentLeft) {
        
        x = 10 + self.qh_pageControlOffsetLeft;
    } else if (self.qh_pageControlAlignment == GQHPageControlAlignmentRight) {
        
        x = CGRectGetWidth(self.slideCollectionView.frame) - size.width - 10 - self.qh_pageControlOffsetRight;
    }
    
    CGFloat y = CGRectGetHeight(self.slideCollectionView.frame) - size.height - 10 - self.qh_pageControlOffsetBottom;
    if ([self.pageControl isKindOfClass:[GQHPageControl class]]) {
        
        GQHPageControl *pageControl = (GQHPageControl *)_pageControl;
        [pageControl sizeToFit];
    }
    
    self.pageControl.frame = CGRectMake(x, y, size.width, size.height);
    self.pageControl.hidden = !_qh_showPageControl;
    
    if (self.backgroundImageView) {
        
        self.backgroundImageView.frame = self.bounds;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    if (!newSuperview) {
        
        [self invalidateTimer];
    }
}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.imagePathArray.count) {
        
        return;
    }
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.pageControl isKindOfClass:[GQHPageControl class]]) {
        
        GQHPageControl *pageControl = (GQHPageControl *)_pageControl;
        pageControl.qh_currentPage = indexOnPageControl;
    } else {
        
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.qh_autoScroll) {
        
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.qh_autoScroll) {
        
        [self setupTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:self.slideCollectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if (!self.imagePathArray.count) {
        
        return;
    }
    int itemIndex = [self currentIndex];
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:itemIndex];
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_slideView:didScrollToIndex:)]) {
        
        [self.qh_delegate qh_slideView:self didScrollToIndex:indexOnPageControl];
    } else if (self.scrollToItemMonitorBlock) {
        
        self.scrollToItemMonitorBlock(indexOnPageControl);
    }
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GQHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    long itemIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_setupCustomCell:forIndex:slideView:)] && [self.qh_delegate respondsToSelector:@selector(qh_customCollectionViewCellClassForSlideView:)] && [self.qh_delegate qh_customCollectionViewCellClassForSlideView:self]) {
        
        [self.qh_delegate qh_setupCustomCell:cell forIndex:itemIndex slideView:self];
        return cell;
    } else if ([self.qh_delegate respondsToSelector:@selector(qh_setupCustomCell:forIndex:slideView:)] && [self.qh_delegate respondsToSelector:@selector(qh_customCollectionViewCellNibForSlideView:)] && [self.qh_delegate qh_customCollectionViewCellNibForSlideView:self]) {
        
        [self.qh_delegate qh_setupCustomCell:cell forIndex:itemIndex slideView:self];
        return cell;
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
    }
    
    NSString *imagePath = self.imagePathArray[itemIndex];
    
    if (!self.qh_onlyText && [imagePath isKindOfClass:[NSString class]]) {
        
        if ([imagePath hasPrefix:@"http"]) {
            
            [cell.qh_imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.qh_placeholderImage];
        } else {
            
            UIImage *image = [UIImage imageNamed:imagePath];
            if (!image) {
                
                image = [UIImage imageWithContentsOfFile:imagePath];
            }
            cell.qh_imageView.image = image;
        }
    } else if (!self.qh_onlyText && [imagePath isKindOfClass:[UIImage class]]) {
        
        cell.qh_imageView.image = (UIImage *)imagePath;
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
    }
    
    if (_qh_textArray.count && itemIndex < _qh_textArray.count) {
        
        cell.qh_title = _qh_textArray[itemIndex];
    }
    
    if (!cell.qh_hasConfigured) {
        
        cell.qh_titleLabelBackgroundColor = self.qh_titleLabelBackgroundColor;
        cell.qh_titleLabelTextColor = self.qh_titleLabelTextColor;
        cell.qh_titleLabelTextFont = self.qh_titleLabelTextFont;
        
        cell.qh_titleLabelHeight = self.qh_titleLabelHeight;
        cell.qh_titleLabelTextAlignment = self.qh_titleLabelTextAlignment;
        
        cell.qh_onlyText = self.qh_onlyText;
        cell.qh_hasConfigured = YES;
        
        cell.qh_imageView.contentMode = self.qh_slideViewContentMode;
        cell.clipsToBounds = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.qh_delegate respondsToSelector:@selector(qh_slideView:didSelectItemAtIndex:)]) {
        
        [self.qh_delegate qh_slideView:self didSelectItemAtIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
    if (self.selectItemMonitorBlock) {
        
        self.selectItemMonitorBlock([self pageControlIndexWithCurrentCellIndex:indexPath.item]);
    }
}

#pragma mark --PrivateMethod
- (void)invalidateTimer {
    
    [_timer invalidate];
    _timer = nil;
}

- (void)setupTimer {
    
    [self invalidateTimer];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.qh_timeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
//    _timer = timer;
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.qh_timeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)automaticScroll {
    
    if (0 == _itemCount) {
        
        return;
    }
    
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (int)currentIndex {
    
    if (CGRectGetWidth(_slideCollectionView.frame) == 0 || CGRectGetHeight(_slideCollectionView.frame) == 0) {
        
        return 0;
    }
    
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        index = (_slideCollectionView.contentOffset.x + 0.5 * _flowLayout.itemSize.height) / _flowLayout.itemSize.width;
    } else {
        
        index = (_slideCollectionView.contentOffset.y + 0.5 * _flowLayout.itemSize.height) / _flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

- (void)scrollToIndex:(NSInteger)index {
    
    if (index >= _itemCount) {
        
        if (self.qh_endless) {
            
            index = _itemCount * 0.1;
            [_slideCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [_slideCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupPageControl {
    
    if (_pageControl) {
        
        [_pageControl removeFromSuperview];
    }
    if (self.imagePathArray.count == 0 || self.qh_onlyText) {
        
        return;
    }
    if (self.imagePathArray.count == 1 && self.qh_hidesForSinglePage) {
        
        return;
    }
    
    int indexOnPageControl = [self pageControlIndexWithCurrentCellIndex:[self currentIndex]];
    switch (self.qh_pageControlStyle) {
        case GQHPageControlStyleAnimated: {
            
            GQHPageControl *pageControl = [[GQHPageControl alloc] init];
            pageControl.qh_numberOfPages = self.imagePathArray.count;
            pageControl.qh_dotColor = self.qh_currentPageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.qh_currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
        case GQHPageControlStyleClassic: {
            
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = self.imagePathArray.count;
            pageControl.currentPageIndicatorTintColor = self.qh_currentPageDotColor;
            pageControl.pageIndicatorTintColor = self.qh_pageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.currentPage = indexOnPageControl;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
        default:
            break;
    }
    if (self.qh_currentPageDotImage) {
        
        self.qh_currentPageDotImage = self.qh_currentPageDotImage;
    }
    if (self.qh_pageDotImage) {
        
        self.qh_pageDotImage = self.qh_pageDotImage;
    }
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index {
    
    return (int)index % self.imagePathArray.count;
}

- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPage:(BOOL)isCurrentPage {
    
    if (!image || !self.pageControl) {
        
        return;
    }
    if ([self.pageControl isKindOfClass:[GQHPageControl class]]) {
        
        GQHPageControl *pageControl = (GQHPageControl *)_pageControl;
        if (isCurrentPage) {
            
            pageControl.qh_currentDotImage = image;
        } else {
            
            pageControl.qh_dotImage = image;
        }
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

- (void)setQh_textArray:(NSArray *)qh_textArray {
    
    _qh_textArray = qh_textArray;
    if (self.qh_onlyText) {
        
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < _qh_textArray.count; i++) {
            
            [temp addObject:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        self.qh_imageURLArray = [temp copy];
    }
}

- (void)setQh_timeInterval:(CGFloat)qh_timeInterval {
    
    _qh_timeInterval = qh_timeInterval;
    [self setQh_autoScroll:self.qh_autoScroll];
}

- (void)setQh_endless:(BOOL)qh_endless {
    
    _qh_endless = qh_endless;
    if ([self.imagePathArray count]) {
        
        self.imagePathArray = self.imagePathArray;
    }
}

- (void)setQh_autoScroll:(BOOL)qh_autoScroll {
    
    _qh_autoScroll = qh_autoScroll;
    [self invalidateTimer];
    if (_qh_autoScroll) {
        
        [self setupTimer];
    }
}

- (void)setQh_scrollDirection:(UICollectionViewScrollDirection)qh_scrollDirection {
    
    _qh_scrollDirection = qh_scrollDirection;
    _flowLayout.scrollDirection = qh_scrollDirection;
}

- (void)setQh_delegate:(id<GQHSlideViewDelegate>)qh_delegate {
    
    _qh_delegate = qh_delegate;
    if ([self.qh_delegate respondsToSelector:@selector(qh_customCollectionViewCellClassForSlideView:)] && [self.qh_delegate qh_customCollectionViewCellClassForSlideView:self]) {
        
        [self.slideCollectionView registerClass:[self.qh_delegate qh_customCollectionViewCellClassForSlideView:self] forCellWithReuseIdentifier:identifier];
    } else if ([self.qh_delegate respondsToSelector:@selector(qh_customCollectionViewCellNibForSlideView:)] && [self.qh_delegate qh_customCollectionViewCellNibForSlideView:self]) {
        
        [self.slideCollectionView registerNib:[self.qh_delegate qh_customCollectionViewCellNibForSlideView:self] forCellWithReuseIdentifier:identifier];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
    }
}

- (void)setQh_placeholderImage:(UIImage *)qh_placeholderImage {
    
    _qh_placeholderImage = qh_placeholderImage;
    if (!self.backgroundImageView) {
        
        UIImageView *backgroundView = [[UIImageView alloc] init];
        backgroundView.contentMode = UIViewContentModeScaleToFill;
        [self insertSubview:backgroundView belowSubview:self.slideCollectionView];
        self.backgroundImageView = backgroundView;
    }
    self.backgroundImageView.image = qh_placeholderImage;
}

- (void)setQh_showPageControl:(BOOL)qh_showPageControl {
    
    _qh_showPageControl = qh_showPageControl;
    _pageControl.hidden = !qh_showPageControl;
}

- (void)setQh_pageControlStyle:(GQHPageControlStyle)qh_pageControlStyle {
    
    _qh_pageControlStyle = qh_pageControlStyle;
    [self setupPageControl];
}

- (void)setQh_pageControlDotSize:(CGSize)qh_pageControlDotSize {
    
    _qh_pageControlDotSize = qh_pageControlDotSize;
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[GQHPageControl class]]) {
        
        GQHPageControl *pageControl = (GQHPageControl *)_pageControl;
        pageControl.qh_dotSize = qh_pageControlDotSize;
    }
}

- (void)setQh_pageDotColor:(UIColor *)qh_pageDotColor {
    
    _qh_pageDotColor = qh_pageDotColor;
    if ([self.pageControl isKindOfClass:[UIPageControl class]]) {
        
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = qh_pageDotColor;
    }
}

- (void)setQh_currentPageDotColor:(UIColor *)qh_currentPageDotColor {
    
    _qh_currentPageDotColor = qh_currentPageDotColor;
    if ([self.pageControl isKindOfClass:[GQHPageControl class]]) {
        
        GQHPageControl *pageControl = (GQHPageControl *)_pageControl;
        pageControl.qh_dotColor = qh_currentPageDotColor;
    } else {
        
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = qh_currentPageDotColor;
    }
}

- (void)setQh_pageDotImage:(UIImage *)qh_pageDotImage {
    
    _qh_pageDotImage = qh_pageDotImage;
    if (self.qh_pageControlStyle != GQHPageControlStyleAnimated) {
        
        self.qh_pageControlStyle = GQHPageControlStyleAnimated;
    }
    [self setCustomPageControlDotImage:qh_pageDotImage isCurrentPage:NO];
}

- (void)setQh_currentPageDotImage:(UIImage *)qh_currentPageDotImage {
    
    _qh_currentPageDotImage = qh_currentPageDotImage;
    if (self.qh_pageControlStyle != GQHPageControlStyleAnimated) {
        
        self.qh_pageControlStyle = GQHPageControlStyleAnimated;
    }
    [self setCustomPageControlDotImage:qh_currentPageDotImage isCurrentPage:YES];
}

- (void)setImagePathArray:(NSArray *)imagePathArray {
    
    [self invalidateTimer];
    _imagePathArray = imagePathArray;
    // 1000*0.1次会跳回到起始页
    _itemCount = self.qh_endless ? self.imagePathArray.count * 1000 : self.imagePathArray.count;
    
    if (imagePathArray.count > 1) {
        
        self.slideCollectionView.scrollEnabled = YES;
        [self setQh_autoScroll:self.qh_autoScroll];
    } else {
        
        self.slideCollectionView.scrollEnabled = NO;
        [self invalidateTimer];
    }
    
    [self setupPageControl];
    [self.slideCollectionView reloadData];
}

@end
