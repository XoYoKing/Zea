//
//  NSDictionary+GQHSafety.h
//  Seed
//
//  Created by GuanQinghao on 25/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GQHSafety)

- (id)qh_safetyObjectForKey:(NSString *)key;

@end


@interface NSMutableDictionary (GQHSafety)


- (void)qh_safetySetObject:(id)object forKey:(id)key;

@end
