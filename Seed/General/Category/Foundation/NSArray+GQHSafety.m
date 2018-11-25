//
//  NSArray+GQHSafety.m
//  Seed
//
//  Created by GuanQinghao on 24/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSArray+GQHSafety.h"

@implementation NSArray (GQHSafety)

+ (instancetype)qh_safetyArrayWithObject:(id)object {
    
    if (object) {
        
        return [self arrayWithObject:object];
    } else {
        
        return [self array];
    }
}

- (id)qh_safetyObjectAtIndex:(NSUInteger)index {
    
    if (index < self.count) {
        
        return [self objectAtIndex:index];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return nil;
    }
}

- (NSArray *)qh_safetySubarrayWithRange:(NSRange)range {
    
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    
    if (location + length <= self.count) {
        
        return [self subarrayWithRange:range];
    } else {
        
        length = self.count - location;
        return [self qh_safetySubarrayWithRange:NSMakeRange(location, length)];
    }
}

- (NSUInteger)qh_safetyIndexOfObject:(id)anObject {
    
    if (anObject) {
        
        return [self indexOfObject:anObject];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return NSNotFound;
    }
}

@end


@implementation NSMutableArray (GQHSafety)

- (void)qh_safetySetObject:(id)object atIndex:(NSUInteger)index {
    
    if (object && index < self.count) {
        
        [self replaceObjectAtIndex:index withObject:object];
    } else if (object && index == self.count) {
        
        [self addObject:object];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetyAddObject:(id)object {
    
    if (object) {
        
        [self addObject:object];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetyInsertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (anObject && index < self.count) {
        
        [self insertObject:anObject atIndex:index];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetyInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    
    if (objects && objects.count == indexes.count && (![indexes indexGreaterThanOrEqualToIndex:(self.count + objects.count)])) {
        
        [self insertObjects:objects atIndexes:indexes];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetyRemoveObjectAtIndex:(NSUInteger)index {
    
    if (index < self.count) {
        
        [self removeObjectAtIndex:index];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetyRemoveObjectsInRange:(NSRange)range {
    
    NSUInteger location = range.location;
    NSUInteger length = range.length;
    
    if (location + length <= self.count) {
        
        [self removeObjectsInRange:range];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

@end
