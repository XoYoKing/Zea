//
//  NSDictionary+GQHJSON.h
//  Seed
//
//  Created by Mac on 2018/9/28.
//  Copyright © 2018 GuanQinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (GQHJSON)

/// JSON字符串转字典
+(NSDictionary*)qh_dictionaryWithJSON:(NSString*)JSON;

/// 字典转JSON字符串
- (NSString *)qh_JSONString;

@end
