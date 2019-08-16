//
//  GQHMacro.h
//  Seed
//
//  Created by GuanQinghao on 14/11/2017.
//  Copyright © 2017 GuanQinghao. All rights reserved.
//

#ifndef GQHMacro_h
#define GQHMacro_h


/// 控制台打印
#ifdef DEBUG

#define NSLog(format, ...)   printf("[%s] [%s] %s [%d] %s\n",[[[NSString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSinceNow:(8 * 60 * 60)]] substringToIndex:19] UTF8String],[[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String],[[NSString stringWithUTF8String:__FUNCTION__] UTF8String],__LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])

#else

#define NSLog(...)

#endif

/// 用户Token
#define USER_TOKEN                          @"userTokenKey"
#define USER_GET_TOKEN                      [[NSUserDefaults standardUserDefaults] valueForKey:USER_TOKEN]

/// token刷新
#define USER_REFRESH_TOKEN                  @"userRefreshTokenKey"
#define USER_GET_REFRESH_TOKEN              [[NSUserDefaults standardUserDefaults] valueForKey:USER_REFRESH_TOKEN]


#endif /* GQHMacro_h */
