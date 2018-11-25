//
//  NSString+GQHSafety.h
//  Seed
//
//  Created by GuanQinghao on 24/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GQHSafety)

- (NSString *)qh_safetySubstringFromIndex:(NSUInteger)from;

- (NSString *)qh_safetySubstringToIndex:(NSUInteger)to;

- (NSString *)qh_safetySubstringWithRange:(NSRange)range;

@end


@interface NSMutableString (GQHSafety)

- (void)qh_safetyInsertString:(NSString *)aString atIndex:(NSUInteger)location;

- (void)qh_safetyAppendString:(NSString *)aString;

- (void)qh_safetySetString:(NSString *)aString;

- (void)qh_safetyDeleteCharactersInRange:(NSRange)range;

@end
