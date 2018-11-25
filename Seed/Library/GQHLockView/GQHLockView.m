//
//  GQHLockView.m
//  SSGestureLockView
//
//  Created by Mac on 2018/10/18.
//  Copyright © 2018 ThisRhythm. All rights reserved.
//


#import "GQHLockView.h"
#import "GQHHeader.h"


NSString *kErrorColor = @"F76432";
NSString *kNormalColor = @"D5DBE8";
NSString *kSelectedColor = @"2381F9";

/// 触点内比例
CGFloat const kRatio = 0.35f;
/// 触点行数
NSInteger const kRowCount = 3;
/// 触点列数
NSInteger const kColumnCount = 3;
/// 连线宽度
CGFloat const kLineWidth = 5.0f;


typedef NS_ENUM(NSUInteger, GQHLockItemViewStyle) {
    
    GQHLockItemViewStyleNormal,
    GQHLockItemViewStyleSelected,
    GQHLockItemViewStyleError,
};

@interface GQHLockItemView : UIView

/// 触点中心点视图
@property (nonatomic, strong) UIView *dotView;

/// 解锁失败颜色
@property (nonatomic, strong) UIColor *errorColor;
/// 解锁正常颜色
@property (nonatomic, strong) UIColor *normalColor;
/// 解锁选中颜色
@property (nonatomic, strong) UIColor *selectedColor;

/// 样式
@property (nonatomic, assign) GQHLockItemViewStyle itemViewStyle;

@end


@implementation GQHLockItemView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.lightGrayColor;
        [self addSubview:self.dotView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 圆角
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat radius = 0.5f * width;
    [self qh_cornerWithRaius:radius byRoundingCorners:UIRectCornerAllCorners];
    
    // 圆角
    CGFloat dotWidth = kRatio * CGRectGetWidth(self.bounds);
    CGFloat dotRadius = 0.5f * dotWidth;
    self.dotView.frame = CGRectMake(0.0f, 0.0f, dotWidth, dotWidth);
    self.dotView.center = CGPointMake(radius, radius);
    [self.dotView qh_cornerWithRaius:dotRadius byRoundingCorners:UIRectCornerAllCorners];
}

- (UIView *)dotView {
    
    if (!_dotView) {
        
        _dotView = [[UIView alloc] init];
        _dotView.backgroundColor = UIColor.grayColor;
    }
    
    return _dotView;
}

- (UIColor *)errorColor {
    
    if (!_errorColor) {
        
        _errorColor = [UIColor qh_colorWithHexString:kErrorColor];
    }
    
    return _errorColor;
}

- (UIColor *)normalColor {
    
    if (!_normalColor) {
        
        _normalColor = [UIColor qh_colorWithHexString:kNormalColor];
    }
    
    return _normalColor;
}

- (UIColor *)selectedColor {
    
    if (!_selectedColor) {
        
        _selectedColor = [UIColor qh_colorWithHexString:kSelectedColor];
    }
    
    return _selectedColor;
}

- (void)setItemViewStyle:(GQHLockItemViewStyle)itemViewStyle {
    
    _itemViewStyle = itemViewStyle;
    
    switch (itemViewStyle) {
            
        case GQHLockItemViewStyleNormal: {
            
            self.backgroundColor = UIColor.lightGrayColor;
            self.dotView.backgroundColor = UIColor.grayColor;
        }
            break;
        case GQHLockItemViewStyleSelected: {
            
            self.backgroundColor = self.normalColor;
            self.dotView.backgroundColor = self.selectedColor;
        }
            break;
        case GQHLockItemViewStyleError: {
            
            self.backgroundColor = self.normalColor;
            self.dotView.backgroundColor = self.errorColor;
        }
            break;
    }
}

@end


@interface GQHLockView ()

/// 触点数组
@property (nonatomic, strong) NSMutableArray <GQHLockItemView *> *itemViewArray;
/// 选中的触点数组
@property (nonatomic, strong) NSMutableArray <GQHLockItemView *> *selectedItemViewArray;

/// 手指触点位置
@property (nonatomic, assign) CGPoint endPoint;
/// 绘线层
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

/// 解锁密码
@property (nonatomic, copy) NSString *value;

@end


@implementation GQHLockView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        for (GQHLockItemView *itemView in self.itemViewArray) {
            
            [self addSubview:itemView];
        }
    }
    
    return self;
}

#pragma mark --View
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds) / kColumnCount;
    CGFloat height = CGRectGetHeight(self.bounds) / kRowCount;
    CGFloat minValue = MIN(width, height);
    
    for (NSInteger i = 0; i < (kRowCount * kColumnCount); i++) {
        
        GQHLockItemView *itemView = self.itemViewArray[i];
        itemView.frame = CGRectMake(0.0f, 0.0f, minValue * (1 - kRatio), minValue * (1 - kRatio));
        
        // 所在行
        NSInteger row = i / kColumnCount;
        // 所在列
        NSInteger column = i % kColumnCount;
        
        // 中心点
        CGPoint center = CGPointMake((0.5f + column) * minValue, (0.5f + row) * minValue);
        itemView.center = center;
    }
}

#pragma mark --Delegate

#pragma mark --TargetMethod
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    GQHLockItemView *itemView = [self itemViewContainPoint:touchPoint];
    if (itemView) {
        
        [self.selectedItemViewArray addObject:itemView];
        self.value = [self.value stringByAppendingString:[NSString stringWithFormat:@"%ld",itemView.tag]];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchPoint)) {
        
        GQHLockItemView *itemView = [self itemViewContainPoint:touchPoint];
        if (itemView && ![self.selectedItemViewArray containsObject:itemView]) {
            
            [self.selectedItemViewArray addObject:itemView];
            self.value = [self.value stringByAppendingString:[NSString stringWithFormat:@"%ld",itemView.tag]];
        }
        
        self.endPoint = touchPoint;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    GQHLockItemView *itemView = [self.selectedItemViewArray lastObject];
    self.endPoint = itemView.center;
    [self setNeedsDisplay];
    
    if (self.qh_delegate && [self.qh_delegate respondsToSelector:@selector(qh_lockView:value:)]) {
        
        [self.qh_delegate qh_lockView:self value:self.value];
    }
    
    if (self.qh_show) {
        
        // 解锁错误
        for (GQHLockItemView *itemView in self.selectedItemViewArray) {
            
            [self alterItemView:itemView style:GQHLockItemViewStyleError];
        }
        
        [self setNeedsDisplay];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.selectedItemViewArray removeAllObjects];
        self.selectedItemViewArray = nil;
        self.value = nil;
        self.endPoint = CGPointZero;
        [self setNeedsDisplay];
        
        for (GQHLockItemView *itemView in self.itemViewArray) {
            
            [self alterItemView:itemView style:GQHLockItemViewStyleNormal];
        }
        
        self.qh_show = NO;
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.selectedItemViewArray removeAllObjects];
    self.selectedItemViewArray = nil;
    self.value = nil;
    self.endPoint = CGPointZero;
    [self setNeedsDisplay];
    
    for (GQHLockItemView *itemView in self.itemViewArray) {
        
        [self alterItemView:itemView style:GQHLockItemViewStyleNormal];
    }
}

#pragma mark --PrivateMethod
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.selectedItemViewArray && self.selectedItemViewArray.count > 0) {
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        GQHLockItemView *startItemView = self.selectedItemViewArray[0];
        [bezierPath moveToPoint:startItemView.center];
        
        self.shapeLayer.strokeColor = UIColor.cyanColor.CGColor;
        
        if (self.qh_show) {
            
            self.shapeLayer.strokeColor = [UIColor qh_colorWithHexString:kErrorColor].CGColor;
        } else {
            
            self.shapeLayer.strokeColor = [UIColor qh_colorWithHexString:kSelectedColor].CGColor;
        }
        
        for (NSInteger i = 0; i < self.selectedItemViewArray.count; i++) {
            
            GQHLockItemView *itemView = self.selectedItemViewArray[i];
            
            if (self.qh_show) {
                
                itemView.itemViewStyle = GQHLockItemViewStyleError;
            } else {
                
                itemView.itemViewStyle = GQHLockItemViewStyleSelected;
            }
            
            [bezierPath addLineToPoint:itemView.center];
        }
        
        if (!CGPointEqualToPoint(self.endPoint, CGPointZero)) {
            
            [bezierPath addLineToPoint:self.endPoint];
        }
        
        self.shapeLayer.path = bezierPath.CGPath;
        
    } else {
        
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
    }
}

/// 触点所在视图
- (GQHLockItemView *)itemViewContainPoint:(CGPoint)point {
    
    for (GQHLockItemView *itemView in self.itemViewArray) {
        
        if (CGRectContainsPoint(itemView.frame, point)) {
            
            return itemView;
        }
    }
    
    return nil;
}

/// 改变触点视图状态
- (void)alterItemView:(GQHLockItemView *)itemView style:(GQHLockItemViewStyle)style {
    
    if (itemView.itemViewStyle != style) {
        
        itemView.itemViewStyle = style;
    }
}

#pragma mark --Setter

#pragma mark --Getter
- (NSMutableArray<GQHLockItemView *> *)itemViewArray {
    
    if (!_itemViewArray) {
        
        _itemViewArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i < (kRowCount * kColumnCount); i++) {
            
            GQHLockItemView *itemView = [[GQHLockItemView alloc] init];
            itemView.tag = i;
            [_itemViewArray addObject:itemView];
        }
    }
    
    return _itemViewArray;
}

- (NSMutableArray<GQHLockItemView *> *)selectedItemViewArray {
    
    if (!_selectedItemViewArray) {
        
        _selectedItemViewArray = [NSMutableArray array];
    }
    
    return _selectedItemViewArray;
}

- (CAShapeLayer *)shapeLayer {
    
    if (!_shapeLayer) {
        
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = UIColor.clearColor.CGColor;
        _shapeLayer.lineWidth = kLineWidth;
        _shapeLayer.lineJoin = @"round";
        
        [self.layer addSublayer:_shapeLayer];
    }
    
    return _shapeLayer;
}

- (NSString *)value {
    
    if (!_value) {
        
        _value = @"";
    }
    
    return _value;
}

@end
