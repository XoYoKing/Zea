//
//  GQHCustomCell.m
//  Seed
//
//  Created by GuanQinghao on 03/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "GQHCustomCell.h"
#import "GQHHeader.h"


#pragma mark -

@interface GQHCustomCell ()

@end

@implementation GQHCustomCell

#pragma mark - Lifecycle
/**
 初始化列表行视图
 
 @param style 行视图样式
 @param reuseIdentifier 重用标识
 @return 自定义行视图
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 初始化自动布局
        [self autoLayoutWithConstraints];
        
        // 其他初始化
        
    }
    
    return self;
}

/**
 布局子视图 -> frame计算
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"");
    
}

/**
 自动布局子视图 -> 约束(mas_make只有一次,自动约束，不要计算)
 */
- (void)autoLayoutWithConstraints {
    NSLog(@"");
    
}

#pragma mark - Delegate

#pragma mark - TargetMethod

#pragma mark - PrivateMethod

#pragma mark - Setter

#pragma mark - Getter

@end
