//
//  NSString+GQHSafety.m
//  Seed
//
//  Created by GuanQinghao on 24/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSString+GQHSafety.h"

@implementation NSString (GQHSafety)

- (NSString *)qh_safetySubstringFromIndex:(NSUInteger)from {
    
    if (from < self.length) {
        
        return [self substringFromIndex:from];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return nil;
    }
}

- (NSString *)qh_safetySubstringToIndex:(NSUInteger)to {
    
    if (to < self.length) {
        
        return [self substringToIndex:to];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return nil;
    }
}

- (NSString *)qh_safetySubstringWithRange:(NSRange)range {
    
    if (range.location + range.length < self.length) {
        
        return [self substringWithRange:range];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return nil;
    }
}

@end

@implementation NSMutableString (GQHSafety)

- (void)qh_safetyInsertString:(NSString *)aString atIndex:(NSUInteger)location {
    
    if (aString && location < self.length) {
        
        [self insertString:aString atIndex:location];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetyAppendString:(NSString *)aString {
    
    if (aString) {
        
        [self appendString:aString];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetySetString:(NSString *)aString {
    
    if (aString) {
        
        [self setString:aString];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

- (void)qh_safetyDeleteCharactersInRange:(NSRange)range {
    
    if (range.location + range.length <= self.length) {
        
        [self deleteCharactersInRange:range];
    } else {
        
        NSLog(@"%s -- %d", __FUNCTION__, __LINE__);
        return;
    }
}

@end
