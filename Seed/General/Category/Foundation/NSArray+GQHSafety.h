//
//  NSArray+GQHSafety.h
//  Seed
//
//  Created by GuanQinghao on 24/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GQHSafety)

+ (instancetype)qh_safetyArrayWithObject:(id)object;

- (id)qh_safetyObjectAtIndex:(NSUInteger)index;

- (NSArray *)qh_safetySubarrayWithRange:(NSRange)range;

- (NSUInteger)qh_safetyIndexOfObject:(id)anObject;

@end


@interface NSMutableArray (GQHSafety)

- (void)qh_safetySetObject:(id)object atIndex:(NSUInteger)index;

- (void)qh_safetyAddObject:(id)object;

- (void)qh_safetyInsertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)qh_safetyInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;

- (void)qh_safetyRemoveObjectAtIndex:(NSUInteger)index;

- (void)qh_safetyRemoveObjectsInRange:(NSRange)range;

@end
