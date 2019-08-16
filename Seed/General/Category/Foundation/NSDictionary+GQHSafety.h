//
//  NSDictionary+GQHSafety.h
//  Seed
//
//  Created by GuanQinghao on 25/01/2018.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (GQHSafety)

/**
 获取任意key值的对象
 
 @param key 字典key值
 @return 字典key值对应对象
 */
- (id)qh_safetyObjectForKey:(NSString *)key;

@end


@interface NSMutableDictionary (GQHSafety)

/**
 安全添加键值对
 
 @param object 任意对象
 @param key 任意对象对应key值
 */
- (void)qh_safetySetObject:(id)object forKey:(id)key;

@end
