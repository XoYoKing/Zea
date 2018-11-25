//
//  GQHPageControl.m
//  Seed
//
//  Created by GuanQinghao on 12/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHPageControl.h"
#import "GQHAnimateDotView.h"
#import "GQHDotView.h"


static CGSize const kDefaultDotSize = {8,8};

static NSInteger const kDefaultNumberOfPages = 0;
static NSInteger const kDefaultCurrentPage = 0;
static NSInteger const kDefaultSpacingBetweenDots = 8;

static BOOL const kDefaultHidesForSinglePage = NO;
static BOOL const kDefaultResizeFromCenter = YES;


@interface GQHPageControl ()

@property (nonatomic, strong) NSMutableArray *dotViewMutableArray;

@end


@implementation GQHPageControl

- (instancetype)init {
    
    if (self = [super init]) {
        
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        [self initialization];
    }
    return self;
}

- (void)initialization {
    
    self.qh_dotViewClass = [GQHAnimateDotView class];
    self.qh_numberOfPages = kDefaultNumberOfPages;
    self.qh_currentPage = kDefaultCurrentPage;
    self.qh_spacingBetweenDots = kDefaultSpacingBetweenDots;
    self.qh_hidesForSinglePage = kDefaultHidesForSinglePage;
    self.qh_resizeFromCenter = kDefaultResizeFromCenter;
}

#pragma mark --touchEvent
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if (touch.view != self) {
        
        NSInteger index = [self.dotViewMutableArray indexOfObject:touch.view];
        if ([self.qh_delegate respondsToSelector:@selector(qh_pageControl:didSelectePageAtIndex:)]) {
            
            [self.qh_delegate qh_pageControl:self didSelectePageAtIndex:index];
        }
    }
}

#pragma mark --Layout
- (void)sizeToFit {
    
    [self updateFrame:YES];
}

- (CGSize)qh_sizeForNumberOfPages:(NSInteger)pageCount {
    
    return CGSizeMake((self.qh_dotSize.width + self.qh_spacingBetweenDots) * pageCount - self.qh_spacingBetweenDots, self.qh_dotSize.height);
}

- (void)updateAllDotView {
    
    if (0 == self.qh_numberOfPages) {
        
        return;
    }
    for (NSInteger i = 0; i < self.qh_numberOfPages; i++) {
        
        UIView *dotView = [[UIView alloc] init];
        if (i < self.dotViewMutableArray.count) {
            
            dotView = [self.dotViewMutableArray objectAtIndex:i];
        } else {
            
            dotView = [self generateDotView];
        }
        [self updateFrameOfDotView:dotView atIndex:i];
    }
    [self qh_checkState:YES atIndex:self.qh_currentPage];
    [self hidesForSinglePage];
}

- (void)updateFrame:(BOOL)override {
    
    CGPoint center = self.center;
    CGSize newSize = [self qh_sizeForNumberOfPages:self.qh_numberOfPages];
    
    if (override || ((CGRectGetWidth(self.frame) < newSize.width || CGRectGetHeight(self.frame) < newSize.height) && !override)) {
        
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), newSize.width, newSize.height);
        if (self.qh_resizeFromCenter) {
            
            self.center = center;
        }
    }
    [self resetAllDotView];
}

- (void)updateFrameOfDotView:(UIView *)dotView atIndex:(NSInteger)index {
    
    CGFloat x = (self.qh_dotSize.width + self.qh_spacingBetweenDots) * index + 0.5 * (CGRectGetWidth(self.frame) - [self qh_sizeForNumberOfPages:self.qh_numberOfPages].width);
    CGFloat y = CGRectGetHeight(self.frame) - 0.5 * self.qh_dotSize.height;
    dotView.frame = CGRectMake(x, y, self.qh_dotSize.width, self.qh_dotSize.height);
}

- (UIView *)generateDotView {
    
    UIView *dotView = [[UIView alloc] init];
    if (self.qh_dotViewClass) {
        
        dotView = [[self.qh_dotViewClass alloc] initWithFrame:CGRectMake(0, 0, self.qh_dotSize.width, self.qh_dotSize.height)];
        if ([dotView isKindOfClass:[GQHAnimateDotView class]] && self.qh_dotColor) {
            
            ((GQHAnimateDotView *)dotView).qh_dotColor = self.qh_dotColor;
        }
    } else {
        
        dotView = [[UIImageView alloc] initWithImage:self.qh_dotImage];
        dotView.frame = CGRectMake(0, 0, self.qh_dotSize.width, self.qh_dotSize.height);
    }
    if (dotView) {
        
        [self addSubview:dotView];
        [self.dotViewMutableArray addObject:dotView];
    }
    dotView.userInteractionEnabled = YES;
    return dotView;
}

- (void)qh_checkState:(BOOL)activated atIndex:(NSInteger)index {
    
    if (self.qh_dotViewClass) {
        
        GQHAbstractDotView *abstractDotView = (GQHAbstractDotView *)[self.dotViewMutableArray objectAtIndex:index];
        if ([abstractDotView respondsToSelector:@selector(qh_checkState:)]) {
            
            [abstractDotView qh_checkState:activated];
        } else {
            
            NSLog(@"Custom view : %@ must implement an '- (void)qh_checkState:(BOOL)activated' method or you can subclass %@ to help you.", self.qh_dotViewClass, [GQHAbstractDotView class]);
        }
    } else if (self.qh_dotImage && self.qh_currentDotImage) {
        
        UIImageView *dotView = (UIImageView *)[self.dotViewMutableArray objectAtIndex:index];
        dotView.image = activated ? self.qh_currentDotImage : self.qh_dotImage;
    }
}

- (void)resetAllDotView {
    
    for (UIView *dotView in self.dotViewMutableArray) {
        
        [dotView removeFromSuperview];
    }
    [self.dotViewMutableArray removeAllObjects];
    [self updateAllDotView];
}

- (void)hidesForSinglePage {
    
    if (self.dotViewMutableArray.count == 1 && self.qh_hidesForSinglePage) {
        
        self.hidden = YES;
    } else {
        
        self.hidden = NO;
    }
}

#pragma mark --Setter
- (void)setQh_dotViewClass:(Class)qh_dotViewClass {
    
    _qh_dotViewClass = qh_dotViewClass;
    self.qh_dotSize = CGSizeZero;
    [self resetAllDotView];
}

- (void)setQh_dotImage:(UIImage *)qh_dotImage {
    
    _qh_dotImage = qh_dotImage;
    [self resetAllDotView];
    self.qh_dotViewClass = nil;
}

- (void)setQh_currentDotImage:(UIImage *)qh_currentDotImage {
    
    _qh_currentDotImage = qh_currentDotImage;
    [self resetAllDotView];
    self.qh_dotViewClass = nil;
}

- (void)setQh_numberOfPages:(NSInteger)qh_numberOfPages {
    
    _qh_numberOfPages = qh_numberOfPages;
    [self resetAllDotView];
}

- (void)setQh_currentPage:(NSInteger)qh_currentPage {
    
    if (self.qh_numberOfPages == 0 || qh_currentPage == _qh_currentPage) {
        
        _qh_currentPage = qh_currentPage;
        return;
    }
    
    [self qh_checkState:NO atIndex:_qh_currentPage];
    _qh_currentPage = qh_currentPage;
    [self qh_checkState:YES atIndex:_qh_currentPage];
}

- (void)setQh_spacingBetweenDots:(NSInteger)qh_spacingBetweenDots {
    
    _qh_spacingBetweenDots = qh_spacingBetweenDots;
    [self resetAllDotView];
}

#pragma mark --Getter
- (NSMutableArray *)dotViewMutableArray {
    
    if (!_dotViewMutableArray) {
        
        _dotViewMutableArray = [[NSMutableArray alloc] init];
    }
    return _dotViewMutableArray;
}

- (CGSize)qh_dotSize {
    
    if (self.qh_dotImage && CGSizeEqualToSize(_qh_dotSize, CGSizeZero)) {
        
        _qh_dotSize = self.qh_dotImage.size;
    } else if (self.qh_dotViewClass && CGSizeEqualToSize(_qh_dotSize, CGSizeZero)){
        
        _qh_dotSize = kDefaultDotSize;
        return _qh_dotSize;
    }
    return _qh_dotSize;
}

@end
