//
//  NSDictionary+GQHSafety.m
//  Seed
//
//  Created by GuanQinghao on 25/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import "NSDictionary+GQHSafety.h"

@implementation NSDictionary (GQHSafety)

- (id)qh_safetyObjectForKey:(NSString *)key {
    
    if (key) {
        
        id object = [self objectForKey:key];
        if (object) {
            
            return object;
        } else {
            
            return @"";
        }
    } else {
        
        return nil;
    }
}

@end


@implementation NSMutableDictionary (GQHSafety)

- (void)qh_safetySetObject:(id)object forKey:(id)key {
    
    if (key) {
        
        if (object) {
            
            [self setValue:object forKey:key];
        } else {
            
            [self setValue:@"" forKey:key];
        }
    } else {
        
        return;
    }
}

@end
