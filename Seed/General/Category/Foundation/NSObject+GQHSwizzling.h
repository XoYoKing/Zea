//
//  NSObject+GQHSwizzling.h
//  Seed
//
//  Created by GuanQinghao on 07/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (GQHSwizzling)

+ (BOOL)qh_overrideMethod:(SEL)originalSel withMethod:(SEL)alterSel;
+ (BOOL)qh_overrideClassMethod:(SEL)originalSel withMethod:(SEL)alterSel;
+ (BOOL)qh_exchangeMethod:(SEL)originalSel withMethod:(SEL)alterSel;
+ (BOOL)qh_exchangeClassMethod:(SEL)originalSel withMethod:(SEL)alterSel;

@end
