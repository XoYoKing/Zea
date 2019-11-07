//
//  NSString+GQHVersion.h
//  Seed
//
//  Created by Mac on 2019/10/11.
//  Copyright © 2019 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSString (GQHVersion)

/**
 大于某一版本
 
 @param version 某一版本
 @return YES or NO
 */
- (BOOL)qh_newerThan:(NSString *)version;

/**
 大于或等于某一版本
 
 @param version 某一版本
 @return YES or NO
 */
- (BOOL)qh_newerThanOrEqualTo:(NSString *)version;

/**
 小于某一版本
 
 @param version 某一版本
 @return YES or NO
 */
- (BOOL)qh_olderThan:(NSString *)version;

/**
 小于或等于某一版本
 
 @param version 某一版本
 @return YES or NO
 */
- (BOOL)qh_olderThanOrEqualTo:(NSString *)version;

@end

NS_ASSUME_NONNULL_END
