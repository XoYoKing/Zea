//
//  GQHAbstractDotView.m
//  Seed
//
//  Created by GuanQinghao on 12/12/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#import "GQHAbstractDotView.h"

@implementation GQHAbstractDotView

- (instancetype)init {
    
    // 公共方法写在父类中，子类调用时必须重写该方法
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in %@",NSStringFromSelector(_cmd),self.class] userInfo:nil];
}

- (void)qh_checkState:(BOOL)activated {
    
    // 公共方法写在父类中，子类调用时必须重写该方法
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in %@",NSStringFromSelector(_cmd),self.class] userInfo:nil];
}

@end
