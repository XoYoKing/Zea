//
//  NSObject+GQHSwizzling.m
//  Seed
//
//  Created by GuanQinghao on 07/03/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSObject+GQHSwizzling.h"
#import <objc/runtime.h>


@implementation NSObject (GQHSwizzling)

+ (BOOL)qh_overrideMethod:(SEL)originalSel withMethod:(SEL)alterSel {
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    if (!originalMethod) {
        
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(originalSel), [self class]);
        return NO;
    }
    
    Method alterMethod = class_getInstanceMethod(self, alterSel);
    if (!alterMethod) {
        
        NSLog(@"alter method %@ not found for class %@", NSStringFromSelector(alterSel), [self class]);
        return NO;
    }
    
    method_setImplementation(originalMethod, class_getMethodImplementation(self, alterSel));
    
    return YES;
}

+ (BOOL)qh_overrideClassMethod:(SEL)originalSel withMethod:(SEL)alterSel {
    
    Class class = object_getClass((id)self);
    return [class qh_overrideMethod:originalSel withMethod:alterSel];
}

+ (BOOL)qh_exchangeMethod:(SEL)originalSel withMethod:(SEL)alterSel {
    
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    if (!originalMethod) {
        
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(originalSel), [self class]);
        return NO;
    }
    
    Method alterMethod = class_getInstanceMethod(self, alterSel);
    if (!alterMethod) {
        
        NSLog(@"alter method %@ not found for class %@", NSStringFromSelector(alterSel), [self class]);
        return NO;
    }
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),class_getInstanceMethod(self, alterSel));
    
    return YES;
}

+ (BOOL)qh_exchangeClassMethod:(SEL)originalSel withMethod:(SEL)alterSel {
    
    Class class = object_getClass((id)self);
    return [class qh_exchangeMethod:originalSel withMethod:alterSel];
}

@end
