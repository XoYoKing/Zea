//
//  GQHPageControl.h
//  Seed
//
//  Created by GuanQinghao on 12/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GQHPageControl;
@protocol GQHPageControlDelegate <NSObject>

@optional

- (void)qh_pageControl:(GQHPageControl *)pageControl didSelectePageAtIndex:(NSInteger)index;

@end


@interface GQHPageControl : UIControl

@property (nonatomic, weak) id<GQHPageControlDelegate> qh_delegate;

@property (nonatomic, strong) Class qh_dotViewClass;

@property (nonatomic, strong) UIImage *qh_dotImage;
@property (nonatomic, strong) UIImage *qh_currentDotImage;
@property (nonatomic, strong) UIColor *qh_dotColor;
@property (nonatomic, assign) CGSize qh_dotSize;

@property (nonatomic, assign) NSInteger qh_numberOfPages;
@property (nonatomic, assign) NSInteger qh_currentPage;

@property (nonatomic, assign) NSInteger qh_spacingBetweenDots;

@property (nonatomic, assign) BOOL qh_hidesForSinglePage;
@property (nonatomic, assign) BOOL qh_resizeFromCenter;

- (CGSize)qh_sizeForNumberOfPages:(NSInteger)pageCount;

@end
